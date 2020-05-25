//
//  BlobMenuMode.swift
//  BlobMenu
//
//  Created by Igor K. on 22.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

public final class BlobMenuModel: ObservableObject {
    @Published public var items: [BlobMenuItem]
    @Published public internal(set) var isOpened: Bool
    @Published public internal(set) var selectedIndex: Int
    @Published public internal(set) var isBlobMenuItemsVisible: Bool = false
    
    public init(items: [BlobMenuItem],
                selectedIndex: Int = 0,
                isOpened: Bool = false) {
        
        self.items = items
        self.isOpened = isOpened
        self.selectedIndex = selectedIndex.limited(0, items.count - 1)
    }
    
    public func selectIndex(_ index: Int) {
        let limitedIndex = index.limited(0, items.count - 1)
        selectedIndex = limitedIndex
    }
    
    public func closeMenu() {
        isOpened = false
        isBlobMenuItemsVisible = false
    }
    
    public func openMenu() {
        withAnimation { self.isOpened = true }
    }
}
