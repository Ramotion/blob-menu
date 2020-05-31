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
    
    static var background: Color {
        return Color(UIColor { $0.userInterfaceStyle == .dark ? #colorLiteral(red: 0.1960526407, green: 0.1960932612, blue: 0.1960500479, alpha: 1) : #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1) })
    }
    
    static var cardBackgound: Color {
        return Color(UIColor { $0.userInterfaceStyle == .dark ? #colorLiteral(red: 0.2470277846, green: 0.2470766604, blue: 0.2470246851, alpha: 1) : #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1) })
    }
    
    static var shadow: Color = Color.black.opacity(0.25)

    static var contrastText: Color {
        return Color(UIColor { $0.userInterfaceStyle == .dark ? #colorLiteral(red: 0.9528377652, green: 0.9530007243, blue: 0.9528275132, alpha: 1) : #colorLiteral(red: 0.1960526407, green: 0.1960932612, blue: 0.1960500479, alpha: 1) })
    }
    
    static var contrastInformation: Color {
        return Color(UIColor { $0.userInterfaceStyle == .dark ? #colorLiteral(red: 0.7371736169, green: 0.7373017669, blue: 0.7371655703, alpha: 1) : #colorLiteral(red: 0.5175882578, green: 0.517680943, blue: 0.5175824165, alpha: 1) })
    }
    
    static var buttonText: Color {
        return Color(UIColor { $0.userInterfaceStyle == .dark ? #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1) : #colorLiteral(red: 0.09132350236, green: 0.3897008598, blue: 0.8640318513, alpha: 1) })
    }
    
    static var buttonBackground: Color {
        return Color(UIColor { $0.userInterfaceStyle == .dark ? #colorLiteral(red: 0.2744759619, green: 0.2745292187, blue: 0.2744725645, alpha: 1) : #colorLiteral(red: 0.9083589911, green: 0.9522650838, blue: 1, alpha: 1) })
    }
}
