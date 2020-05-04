//
//  StickyEffectView.swift
//  BlobMenu
//
//  Created by Igor K. on 27.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

struct StickyEffectShape: Shape {
    
    private let pathGenerator = StickyPathGenerator.default
    private let baseRect: CGRect
    private let figureRect: CGRect
    private let figureCornerRadius: CGFloat
    private let avulsionDistance: CGFloat
    
    init(baseRect: CGRect,
         figureRect: CGRect,
         figureCornerRadius: CGFloat,
         avulsionDistance: CGFloat) {
        
        self.baseRect = baseRect
        self.figureRect = figureRect
        self.figureCornerRadius = figureCornerRadius
        self.avulsionDistance = avulsionDistance
    }
    
    func path(in rect: CGRect) -> Path {
        
        let path = pathGenerator.generatePath(baseRect: baseRect,
                                              figureRect: figureRect,
                                              figureCornerRadius: figureCornerRadius,
                                              avulsionDistance: avulsionDistance)
        
        return Path(path)
    }
}
