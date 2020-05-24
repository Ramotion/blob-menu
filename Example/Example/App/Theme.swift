//
//  Theme.swift
//  Example
//
//  Created by Igor K. on 22.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    static let lightGray = Color(#colorLiteral(red: 0.899865165, green: 0.899865165, blue: 0.899865165, alpha: 1))
    
    static var background: Color {
        return Color(UIColor { $0.userInterfaceStyle == .dark ? #colorLiteral(red: 0.1960526407, green: 0.1960932612, blue: 0.1960500479, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) })
    }
    
    static var contrast: Color {
        return Color(UIColor { $0.userInterfaceStyle == .dark ? #colorLiteral(red: 0.9705940673, green: 0.9705940673, blue: 0.9705940673, alpha: 1) : #colorLiteral(red: 0.1960526407, green: 0.1960932612, blue: 0.1960500479, alpha: 1) })
    }
    
    static var shadow: Color { contrast.opacity(0.2) }
    static var stroke = Color.gray
    
    static var textColor: Color { background }
    static var contrastTextColor: Color { contrast }
    static var informationColor: Color { background.opacity(0.6) }
    static var contrastInformationColor: Color { contrast.opacity(0.6) }
}
