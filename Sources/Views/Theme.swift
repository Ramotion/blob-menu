//
//  Theme.swift
//  BlobMenu
//
//  Created by Igor K. on 16.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    
    static var hamburgerColor: Color {
        return Color(UIColor { $0.userInterfaceStyle == .dark ? #colorLiteral(red: 0.1960526407, green: 0.1960932612, blue: 0.1960500479, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) })
    }
    
    static var backgroundColor: Color {
        return Color(UIColor { $0.userInterfaceStyle == .dark ? #colorLiteral(red: 0.9705940673, green: 0.9705940673, blue: 0.9705940673, alpha: 1) : #colorLiteral(red: 0.1960526407, green: 0.1960932612, blue: 0.1960500479, alpha: 1) })
    }
    
    static let selectionColor = Color(#colorLiteral(red: 0.9983773828, green: 0.7375702262, blue: 0.1739521325, alpha: 1))
}


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
