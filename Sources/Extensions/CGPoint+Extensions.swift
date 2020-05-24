//
//  CGPoint+Extensions.swift
//  BlobMenu
//
//  Created by Igor K. on 29.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI


func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func += (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs + rhs
}

func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

func -= (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs - rhs
}

func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
}

func *= (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs * rhs
}

func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
}

func /= (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs / rhs
}

func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}


extension CGPoint {
    var length: CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }
}
