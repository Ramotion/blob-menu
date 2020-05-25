//
//  BlobMenuItem.swift
//  BlobMenu
//
//  Created by Igor K. on 29.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

public struct BlobMenuItem: Identifiable, Hashable {
    
    public let id = UUID()
    public let selectedIcon: Image
    public let unselectedIcon: Image
    public let offset: CGPoint
    
    public init(selectedIcon: Image,
         unselectedIcon: Image,
         offset: CGPoint = .zero) {
        
        self.selectedIcon = selectedIcon
        self.unselectedIcon = unselectedIcon
        self.offset = offset
    }
    
    public init(icon: Image, offset: CGPoint = .zero) {
        self.selectedIcon = icon
        self.unselectedIcon = icon
        self.offset = offset
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
