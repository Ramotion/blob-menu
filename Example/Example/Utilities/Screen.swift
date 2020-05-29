//
//  Screen.swift
//  Example
//
//  Created by Igor K. on 22.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

struct Screen<Content>: View where Content: View {
    let content: () -> Content
    let backgoundColor: Color
    
    init(color: Color = .white, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.backgoundColor = color
    }
    
    var body: some View {
        ZStack {
            backgoundColor.edgesIgnoringSafeArea(.all)
            content()
        }
        .frame(size: UIScreen.main.bounds.size)
    }
}
