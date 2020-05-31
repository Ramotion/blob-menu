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

struct Buttons {
    static func roundRect(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action, label:  {
            Text(title).font(Font.system(size: 15))
        })
        .buttonStyle(RoundRectStyle(fontColor: Color.buttonText, backgroundColor: Color.buttonBackground))
    }
}

struct RoundRectStyle: ButtonStyle {
    let fontColor: Color
    let backgroundColor: Color
    
    public func makeBody(configuration: RoundRectStyle.Configuration) -> some View {
        return RoundRectButton(fontColor: fontColor, backgroundColor: backgroundColor, configuration: configuration)
    }
    
    private struct RoundRectButton: View {
        let fontColor: Color
        let backgroundColor: Color
        let configuration: ButtonStyle.Configuration
        
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            configuration.label
                .foregroundColor(isEnabled ? fontColor : backgroundColor.opacity(0.6))
                .padding(.horizontal, 24)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                    .fill(isEnabled ? backgroundColor : backgroundColor.opacity(0.1))
                )
                .compositingGroup()
                .opacity(configuration.isPressed ? 0.7 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
        }
    }
}
