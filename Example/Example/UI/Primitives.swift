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
