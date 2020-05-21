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


extension View {
    public func greedyFrame(alignment: Alignment) -> some View {
        return self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}


extension Binding where Value: BindingAnimatable {
    var animatable: Binding<Value>  {
        return Binding<Value>(get: { return self.wrappedValue },
                              set: { b in withAnimation { self.wrappedValue = b } })
    }
}

protocol BindingAnimatable { }

extension Bool: BindingAnimatable { }
extension Int: BindingAnimatable { }


extension View {
    var rotateAroundOnTap: some View {
        self.modifier(RotationAroundModifier())
    }
}

struct RotationAroundModifier: ViewModifier {
    @State private var animationAngle = 0.0
        
    func body(content: Content) -> some View {
        return content
            .onTapGesture { withAnimation { self.animationAngle += 360 } }
            .rotation3DEffect(.degrees(animationAngle), axis: (x: 0, y: 1, z: 0))
            .animation(.interpolatingSpring(stiffness: 150, damping: 17))
    }
}


extension View {
    var scaleOnTap: some View {
        self.modifier(TapScaleModifier())
    }
}

struct TapScaleModifier: ViewModifier {
    
    @State private var scaleValue: CGFloat = 1
    
    func body(content: Content) -> some View {
        content
        .scaleEffect(self.scaleValue)
        .onTouchGesture(
            touchBegan: { withAnimation { self.scaleValue = 1.05 } },
            touchEnd: { _ in withAnimation { self.scaleValue = 1.0 } }
        )
    }
}


extension UIEdgeInsets {
    public init(uniform value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
    
    public init(horizontal h: CGFloat, vertical v: CGFloat) {
        self.init(top: v, left: h, bottom: v, right: h)
    }
}
