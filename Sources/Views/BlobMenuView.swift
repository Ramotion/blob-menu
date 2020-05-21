//
//  BlobMenuView.swift
//  BlobMenu
//
//  Created by Igor K. on 27.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI

public struct BlobMenuView: View {
    
    @State public var selectedIndex: Int
    
    @EnvironmentObject private var environment: BlobMenuEnvironment
    private let items: [MenuItem]
    private let configuration: BlobMenuConfiguration
    
    public static func createMenu(items: [MenuItem],
            selectedIndex: Int = 0,
            configuration: BlobMenuConfiguration = .default) -> some View {
        
        return BlobMenuView(items: items,
                            selectedIndex: selectedIndex,
                            configuration: configuration)
            .environmentObject(BlobMenuEnvironmentKey.defaultValue)
    }
    
    private init(items: [MenuItem],
                 selectedIndex: Int = 0,
                 configuration: BlobMenuConfiguration = .default) {
        
        self.items = items
        self.configuration = configuration
        
        let limitedIndex = selectedIndex.limited(0, items.count - 1)
        _selectedIndex = State<Int>.init(initialValue: limitedIndex)
        
        BlobMenuEnvironmentKey.defaultValue.selectedIndex = limitedIndex
        
        UIWindow.current?.addGesture(type: .tap) { _ in
            BlobMenuEnvironmentKey.defaultValue.isMenuItemsVisible = false
            BlobMenuEnvironmentKey.defaultValue.isOpened = false
        }
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            HStack {
                Spacer()
                self.background.overlay(self.itemsView)
                Spacer().size(width: self.environment.isOpened ? nil : Theme.padding)
            }
            .backgroundPreferenceValue(BackgroundPreferenceKey.self) { p in
                GeometryReader { geometry in
                    self.createStickyView(geometry: geometry, preferences: p)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
            HStack {
                Spacer()
                HamburgerView(isOpened: environment.isOpened, color: configuration.hamburgerColor)
                Spacer().size(width: Theme.padding)
            }
        }
        .frame(height: Theme.height)
    }
    
    private func createStickyView(geometry: GeometryProxy, preferences: [BackgroundPreferenceData]) -> some View {
        
        guard !self.environment.isMenuItemsVisible else {
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
        .keyframes(size: Theme.backgroundSizeKeyframes(isOpened: environment.isOpened, items: items), progress: environment.isOpened ? 1 : 0)
        .animation(Animation.interpolatingSpring(mass: 1, stiffness: 170, damping: 15, initialVelocity: 1).delay(environment.isOpened ? 0.12 : 0))
        .onAnimationCompleted(condition: environment.isOpened) {
            self.environment.isMenuItemsVisible = true
        }
        .onTapGesture {
            withAnimation {
                self.environment.isOpened = true
            }
        }
        .allowsHitTesting(!self.environment.isOpened)
    }
        
    private var itemsView: some View {
        Group {
            if Theme.isScrollable(items: items) {
                ScrollView(.horizontal, showsIndicators: false) { itemsContent }
            } else {
                itemsContent
            }
        }
        .clipShape(Capsule(style: .circular))
        .animation(Animation.easeInOut(duration: 0.35).delay(0.15))
        .allowsHitTesting(self.environment.isMenuItemsVisible)
    }
    
    private var itemsContent: some View {
        HStack(spacing: 20) {
            ForEach(items.enumeratedArray(), id: \.element) { index, item in
                MenuItemView(item: item,
                    isSelected: self.selectedIndex == index,
                    isOpened: self.environment.isMenuItemsVisible,
                    selectionColor: self.configuration.selectionColor)
                .onTapGesture {
                    self.selectedIndex = index
                    BlobMenuEnvironmentKey.defaultValue.selectedIndex = index
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
        static let menuItemsSpace: CGFloat = 20
        static let stickyEffectAvulsionDistance: CGFloat = 120
        static let closedSize = CGSize(width: 60, height: height)
        static let collapsedSize = CGSize(width: 90, height: 70)
        static let maxOpenSize = CGSize(width: UIScreen.main.bounds.width - 60, height: height)
        
        private static func itemsSize(items: [MenuItem]) -> CGSize {
            let w = CGFloat(items.count) * MenuItemView.Theme.size.width + CGFloat(items.count - 1) * menuItemsSpace
            return CGSize(width: w, height: height)
        }
        
        static func openedSize(items: [MenuItem]) -> CGSize {
            if isScrollable(items: items) {
                return maxOpenSize
            } else {
                return itemsSize(items: items)
            }
        }
        
        static func isScrollable(items: [MenuItem]) -> Bool {
            return itemsSize(items: items).width > maxOpenSize.width
        }
        
        static func backgroundSizeKeyframes(isOpened: Bool, items: [MenuItem]) -> [Keyframe<CGSize>] {
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
