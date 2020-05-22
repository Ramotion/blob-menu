//
//  Transitions.swift
//  BlobMenu
//
//  Created by Igor K. on 23.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var blobBlobMenuItem: AnyTransition {
        return AnyTransition.scale.combined(with: AnyTransition.rotation)
            .animation(.easeOut(duration: 0.35))
    }
}


extension AnyTransition {
    
    static var rotation: AnyTransition {
        return AnyTransition.asymmetric(insertion: .rotationIn, removal: .rotationOut)
    }
    
    static var rotationIn: AnyTransition {
        return AnyTransition.modifier(active: RotationTransition(percentage: -0.15), identity: RotationTransition(percentage: 0))
    }
    
    static var rotationOut: AnyTransition {
        return AnyTransition.modifier(active: RotationTransition(percentage: 0.85), identity: RotationTransition(percentage: 1))
    }
}

struct RotationTransition: GeometryEffect {
    var percentage: CGFloat
    
    var animatableData: CGFloat {
        get { percentage }
        set { percentage = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let angle = CGFloat.animationAngle(percentage: percentage)
        let rotation = CGAffineTransform(rotationAngle: angle)
        let from = CGAffineTransform(translationX: -size.width / 2.0, y: -size.height / 2.0)
        let to = CGAffineTransform(translationX: size.width / 2.0, y: size.height / 2.0)
        return ProjectionTransform(from.concatenating(rotation).concatenating(to))
    }
}


//MARK: - Utilities
extension FloatingPoint {
    
    static func animationAngle<T: FloatingPoint>(percentage: T) -> T {
        let pi2 = T.pi * 2
        let sign: T = percentage < 0 ? -1 : 1
        return sign * (pi2 * (1 - percentage)).truncatingRemainder(dividingBy: pi2)
    }
}
