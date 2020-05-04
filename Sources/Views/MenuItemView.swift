//
//  MenuItemView.swift
//  BlobMenu
//
//  Created by Igor K. on 29.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

public struct MenuItemView: View {
    
    public let item: MenuItem
    public let isSelected: Bool
    @Binding public var isOpened: Bool
    
    public var body: some View {
        ZStack {
            selectionView
            ringView
            if isOpened { iconView }
        }
        .padding(Theme.contentInsets)
        .contentShape(Rectangle())
        .frame(size: Theme.size)
    }
    
    private var iconView: some View {
        let image = isSelected ? item.selectedIcon : item.unselectedIcon
        return image
            .offset(item.offset)
            .transition(AnyTransition.blobMenuItem)
    }
    
    private var selectionView: some View {
        Circle()
        .foregroundColor(Color.selection)
        .frame(size: Theme.contentSize)
        .opacity(isSelected ? 1 : 0)
        .animation(nil)
        .scaleEffect(isOpened ? (isSelected ? 1 : 0.8) : CGFloat.minAlowedScale)
        .animation(.interpolatingSpring(mass: 1, stiffness: 170, damping: isOpened ? 8 : 50, initialVelocity: 1))
    }
    
    private var ringView: some View {
        let show = isOpened && isSelected
        return Circle()
        .stroke(Color.selection)
        .frame(size: Theme.contentSize)
        .opacity(show ? 0 : 1)
        .animation(show ? Animation.easeInOut.delay(0.2) : nil)
        .scaleEffect(show ? 1.3 : CGFloat.minAlowedScale)
        .animation(show ? .easeInOut : nil)
    }
}


//MARK: - Theme
extension MenuItemView {
    enum Theme {
        static let size = CGSize(uniform: 60)
        static let contentInsets: CGFloat = 15
        static let contentSize = CGSize(uniform: size.height - contentInsets)
    }
}
