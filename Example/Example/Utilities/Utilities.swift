//
//  Utilities.swift
//  Example
//
//  Created by Igor K. on 05.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension UIWindow {
    
    static var safeInsets: UIEdgeInsets {
        return current?.safeAreaInsets ?? UIEdgeInsets(top: 44, left: 0, bottom: 34, right: 0)
    }
        
    static var isFullScreen: Bool {
        return current?.frame == UIScreen.main.bounds
    }
}


extension Binding where Value == Bool {
    var animatable: Binding<Value>  {
        return Binding<Value>(get: { return self.wrappedValue },
                              set: { b in withAnimation { self.wrappedValue = b } })
    }
}
