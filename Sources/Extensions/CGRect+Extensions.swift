//
//  CGRect+Extensions.swift
//  BlobMenu
//
//  Created by Igor K. on 20.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

extension CGRect {
    
    public init(size: CGSize) {
        self.init(origin: .zero, size: size)
    }
    
    public var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
    
    public init(center: CGPoint, size: CGSize) {
        self.init(x: center.x - size.width / 2, y: center.y - size.height / 2, width: size.width, height: size.height)
    }
}
