//
//  BezierUtilities.swift
//  BlobMenu
//
//  Created by Igor K. on 29.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

struct BezierUtilities {
    //
    // get Beizer curve points
    // p0 - start point
    // p1 - first control point
    // p2 - second control point
    // p3 - finish point
    //
    static func getCubeCurvePoints(p0: CGPoint, p1: CGPoint, p2: CGPoint, p3: CGPoint) -> [CGPoint] {
        //0 <= t >= 1
        // used t = 0.3...0.7 for fast calculation
        var points: [CGPoint] = []
        for t in stride(from: 0.3, to: 0.7, by: 0.1) {
            let x0 = pow((1-t), 3) * Double(p0.x)
            let x1 = 3 * t * pow((1-t), 2) * Double(p1.x)
            let x2 = 3 * pow(t, 2) * (1-t) * Double(p2.x)
            let x3 = pow(t, 3) * Double(p3.x)
            let X = x0 + x1 + x2 + x3
            
            let y0 = pow((1-t), 3) * Double(p0.y)
            let y1 = 3 * t * pow((1-t), 2) * Double(p1.y)
            let y2 = 3 * pow(t, 2) * (1-t) * Double(p2.y)
            let y3 = pow(t, 3) * Double(p3.y)
            let Y = y0 + y1 + y2 + y3
            points.append(CGPoint(x: X, y: Y))
        }
        
        return points
    }
    
    //
    // get Beizer curve Apex point (Middle of the line)
    // p0 - start point
    // p1 - first control point
    // p2 - second control point
    // p3 - finish point
    //
    static func getCubeCurveApexPoint(p0: CGPoint, p1: CGPoint, p2: CGPoint, p3: CGPoint) -> CGPoint {
        let t = 0.5 //Apex need only, 0 <= t >= 1
        
        let x0 = pow((1-t), 3) * Double(p0.x)
        let x1 = 3 * t * pow((1-t), 2) * Double(p1.x)
        let x2 = 3 * pow(t, 2) * (1-t) * Double(p2.x)
        let x3 = pow(t, 3) * Double(p3.x)
        let X = x0 + x1 + x2 + x3
        
        let y0 = pow((1-t), 3) * Double(p0.y)
        let y1 = 3 * t * pow((1-t), 2) * Double(p1.y)
        let y2 = 3 * pow(t, 2) * (1-t) * Double(p2.y)
        let y3 = pow(t, 3) * Double(p3.y)
        let Y = y0 + y1 + y2 + y3
        
        return CGPoint(x: X, y: Y)
    }
}
