//
//  BlobMenuView.swift
//  BlobMenu
//
//  Created by Igor K. on 27.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI

public struct BlobMenuView: View {
    
    private let configuration: BlobMenuConfiguration
    @ObservedObject private var viewModel: BlobMenuModel
    
    public init(model: BlobMenuModel,
                configuration: BlobMenuConfiguration = .default) {
        
        self.viewModel = model
        self.configuration = configuration
        
        UIWindow.current?.addGesture(type: .tap) {[weak model] _ in
            model?.closeMenu()
        }
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            HStack {
                Spacer()
                self.background.overlay(self.itemsView)
                Spacer().size(width: self.viewModel.isOpened ? nil : Theme.padding)
            }
            .backgroundPreferenceValue(BackgroundPreferenceKey.self) { p in
                GeometryReader { geometry in
                    self.createStickyView(geometry: geometry, preferences: p)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
            HStack {
                Spacer()
                HamburgerView(isOpened: viewModel.isOpened, color: configuration.hamburgerColor)
                Spacer().size(width: Theme.padding)
            }
        }
        .frame(height: Theme.height)
    }
    
    private func createStickyView(geometry: GeometryProxy, preferences: [BackgroundPreferenceData]) -> some View {
        
        guard !self.viewModel.isBlobMenuItemsVisible else {
            return AnyView(Color.clear)
        }
        
        let p = preferences.first
        let f = geometry.frame(in: .local)
        let b = p != nil ? geometry[p!.bounds] : .zero
        
        let r = Theme.closedSize.height / 2
        let w = f.width - b.maxX + r
        let base = CGRect(x: f.width, y: f.minY, width: 50, height: f.height)
        
        let effectView = StickyEffectShape(baseRect: base, figureRect: b, figureCornerRadius: r, avulsionDistance: Theme.stickyEffectAvulsionDistance)
            
        return effectView
            .fill(configuration.backgroundColor)
            .frame(size: CGSize(width: w, height: f.height))
            .asAnyView
    }
    
    private var background: some View {
        BackgroundView(color: configuration.backgroundColor)
        .cornerRadius(Theme.closedSize.height / 2)
        .keyframes(size: Theme.backgroundSizeKeyframes(isOpened: viewModel.isOpened, items: viewModel.items), progress: viewModel.isOpened ? 1 : 0)
        .animation(Animation.interpolatingSpring(mass: 1, stiffness: 170, damping: 15, initialVelocity: 1).delay(viewModel.isOpened ? 0.12 : 0))
        .onAnimationCompleted(condition: viewModel.isOpened) {
            self.viewModel.isBlobMenuItemsVisible = true
        }
        .onTapGesture {
            withAnimation {
                self.viewModel.isOpened = true
            }
        }
        .allowsHitTesting(!self.viewModel.isOpened)
    }
        
    private var itemsView: some View {
        Group {
            if Theme.isScrollable(items: viewModel.items) {
                ScrollView(.horizontal, showsIndicators: false) { itemsContent }
            } else {
                itemsContent
            }
        }
        .clipShape(Capsule(style: .circular))
        .animation(Animation.easeInOut(duration: 0.35).delay(0.15))
        .allowsHitTesting(self.viewModel.isBlobMenuItemsVisible)
    }
    
    private var itemsContent: some View {
        HStack(spacing: 20) {
            ForEach(viewModel.items.enumeratedArray(), id: \.element) { index, item in
                BlobMenuItemView(item: item,
                    isSelected: self.viewModel.selectedIndex == index,
                    isOpened: self.viewModel.isBlobMenuItemsVisible,
                    selectionColor: self.configuration.selectionColor)
                .onTapGesture {
                    guard self.viewModel.selectedIndex != index else { return }
                    self.viewModel.selectIndex(index)
                }
            }
        }
    }
}


//MARK: - Theme
extension BlobMenuView {
    enum Theme {
        static let height: CGFloat = 60
        static let padding: CGFloat = 10
        static let BlobMenuItemsSpace: CGFloat = 20
        static let stickyEffectAvulsionDistance: CGFloat = 120
        static let closedSize = CGSize(width: 60, height: height)
        static let collapsedSize = CGSize(width: 90, height: 70)
        static let maxOpenSize = CGSize(width: UIScreen.main.bounds.width - 60, height: height)
        
        private static func itemsSize(items: [BlobMenuItem]) -> CGSize {
            let w = CGFloat(items.count) * BlobMenuItemView.Theme.size.width + CGFloat(items.count - 1) * BlobMenuItemsSpace
            return CGSize(width: w, height: height)
        }
        
        static func openedSize(items: [BlobMenuItem]) -> CGSize {
            if isScrollable(items: items) {
                return maxOpenSize
            } else {
                return itemsSize(items: items)
            }
        }
        
        static func isScrollable(items: [BlobMenuItem]) -> Bool {
            return itemsSize(items: items).width > maxOpenSize.width
        }
        
        static func backgroundSizeKeyframes(isOpened: Bool, items: [BlobMenuItem]) -> [Keyframe<CGSize>] {
            if isOpened {
                //will use during opening animation
                return [
                    Keyframe<CGSize>(value: closedSize, progress: 0),
                    Keyframe<CGSize>(value: openedSize(items: items), progress: 1)
                ]
            } else {
                //will use during closing animation
                return [
                    Keyframe<CGSize>(value: closedSize, progress: 0),
                    Keyframe<CGSize>(value: collapsedSize, progress: 0.3),
                    Keyframe<CGSize>(value: openedSize(items: items), progress: 1)
                ]
            }
        }
    }
}
