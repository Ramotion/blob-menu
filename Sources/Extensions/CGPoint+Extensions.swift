//
//  CGPoint+Extensions.swift
//  BlobMenu
//
//  Created by Igor K. on 29.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI


public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func += (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs + rhs
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func -= (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs - rhs
}

public func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
}

public func *= (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs * rhs
}

public func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
}

public func /= (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs / rhs
}

public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}


extension CGPoint {
    public var length: CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }
}
