//
//  BlobMenuConfiguration.swift
//  BlobMenu
//
//  Created by Igor K. on 23.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

public struct BlobMenuConfiguration {
    
    public let hamburgerColor: Color
    public let backgroundColor: Color
    public let selectionColor: Color
    
    public init(hamburgerColor: Color,
                backgroundColor: Color,
                selectionColor: Color) {
        
        self.hamburgerColor = hamburgerColor
        self.backgroundColor = backgroundColor
        self.selectionColor = selectionColor
    }
    
    public static var `default`: BlobMenuConfiguration {
        BlobMenuConfiguration(hamburgerColor: Color.hamburgerColor,
                              backgroundColor: Color.backgroundColor,
                              selectionColor: Color.selectionColor)
    }
}
