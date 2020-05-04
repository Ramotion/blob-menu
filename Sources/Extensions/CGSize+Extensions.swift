//
//  CGSize+Extensions.swift
//  BlobMenu
//
//  Created by Igor K. on 26.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

extension CGSize {
    public init(uniform side: CGFloat) {
        self.init(width: side, height: side)
    }
}


extension CGSize: VectorArithmetic {

    public mutating func scale(by rhs: Double) {
        self.width = self.width * CGFloat(rhs)
        self.height = self.height * CGFloat(rhs)
    }
    
    public var magnitudeSquared: Double {
        return Double(sqrt( self.width * self.width + self.height * self.height ))
    }
    
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
}
