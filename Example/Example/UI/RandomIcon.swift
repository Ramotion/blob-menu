//
//  RandomIcon.swift
//  Example
//
//  Created by Igor K. on 22.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI


struct RandomIcon: View {
    
    var body: some View {
        let index = Int.random(in: 0..<5)
        let result: AnyView
        switch index {
        case 0: result = circle.frame(size: CGSize(uniform: 30)).asAnyView
        case 1: result = roundedRectangle.frame(size: CGSize(uniform: 30)).asAnyView
        case 2: result = capsule.frame(size: CGSize(width: 30, height: 20)).asAnyView
        case 3: result = elipse.frame(size: CGSize(width: 20, height: 30)).asAnyView
        default: result = polygon.frame(size: CGSize(uniform: 30)).asAnyView
        }
        return result.rotateAroundOnTap
    }
    
    private var circle: some View {
        Circle().fill(Color.random)
    }
    
    private var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 6).fill(Color.random)
    }
    
    private var rectangle: some View {
        Rectangle().fill(Color.random)
    }
    
    private var capsule: some View {
        Capsule(style: RoundedCornerStyle.circular).fill(Color.random)
    }
    
    private var elipse: some View {
        Ellipse().fill(Color.random)
    }
    
    private var polygon: some View {
        let sidesCount = Int.random(in: 3...8)
        return PolygonShape(sides: sidesCount).fill(Color.random)
    }
}


private struct PolygonShape: Shape {
    var sides: Int
    
    func path(in rect: CGRect) -> Path {
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        var path = Path()
                
        for i in 0..<sides {
            let angle = Double(i) / Double(sides) * 2 * Double.pi
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            
            if i == 0 {
                path.move(to: pt)
            } else {
                path.addLine(to: pt)
            }
        }
        
        path.closeSubpath()
        return path
    }
}
