//
//  RandomIcon.swift
//  Example
//
//  Created by Igor K. on 22.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

var logo: some View {
    ZStack {
        Color.background
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.stroke, lineWidth: 0.5))
            .frame(size: CGSize(uniform: 60))
            .shadow(color: Color.shadow, radius: 7, y: 3)
        Image("Logo")
            .resizable()
            .frame(size: CGSize(uniform: 50))
    }.rotateAroundOnTap
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
            .frame(size: CGSize(width: 150, height: 44))
            .background(RoundedRectangle(cornerRadius: 10)
            .fill(isEnabled ? backgroundColor : backgroundColor.opacity(0.1)))
            .compositingGroup()
                .shadow(color: Color.shadow, radius: 3)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
        }
    }
}


enum Buttons {
    
    static func roundRect(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action, label:  {
            Text(title).font(.body)
        })
        .buttonStyle(RoundRectStyle(fontColor: Color.background, backgroundColor: Color.contrast))
    }
}
