//
//  CommonUtilities.swift
//  BlobMenu
//
//  Created by Igor K. on 21.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    public func frame(size: CGSize, alignment: Alignment = .center) -> some View {
    
        return self.frame(width: size.width, height: size.height, alignment: alignment)
    }
    
    public func offset(_ offset: CGPoint) -> some View {
        return self.offset(x: offset.x, y: offset.y)
    }
    
    public var asAnyView: AnyView {
        return AnyView(self)
    }
}


extension Spacer {
    
    public func size(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        
        guard width != nil || height != nil else {
            return AnyView(self)
        }
        
        return AnyView(self.frame(width: width, height: height))
    }
}


extension View {
    // If condition is met, apply modifier, otherwise, leave the view untouched
    public func conditionalModifier<T>(_ condition: Bool, _ modifier: T) -> some View where T: ViewModifier {
        Group {
            if condition {
                self.modifier(modifier)
            } else {
                self
            }
        }
    }

    // Apply trueModifier if condition is met, or falseModifier if not.
    public func conditionalModifier<M1, M2>(_ condition: Bool, _ trueModifier: M1, _ falseModifier: M2) -> some View where M1: ViewModifier, M2: ViewModifier {
        Group {
            if condition {
                self.modifier(trueModifier)
            } else {
                self.modifier(falseModifier)
            }
        }
    }
}

extension CGFloat {
    static let minAlowedScale: CGFloat = 0.001
}


func delay(_ delay: TimeInterval, _ closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
