//
//  Utilities.swift
//  Example
//
//  Created by Igor K. on 05.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI


extension Binding where Value == Bool {
    var animatable: Binding<Bool>  {
        return Binding<Bool>(get: { return self.wrappedValue },
                              set: { b in withAnimation { self.wrappedValue = b } })
    }
}

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
