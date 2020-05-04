//
//  ScaleKeyframesAnimation.swift
//  BlobMenu
//
//  Created by Igor K. on 26.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

/// An example of a `AnimatableModifier` to animate the `.scale` of a `View ` in an keyframe animation.
private struct ScaleModifier: AnimatableModifier {
    var animatableData: CGFloat = .zero
    
    func body(content: Content) -> some View {
        return content.scaleEffect(animatableData, anchor: .center)
    }
}

extension View {

    /// Create a keyframe animation of the scale of the view. Use an `.animation` modifier to specify the animation.
    /// - Parameter keyframes: The array of keyframes. Does not have to be sorted.
    /// - Parameter progress: The progress of the animation. Use a `@State` variable of value `0` and set to `1` to start animation.
    private func keyframes(scale keyframes: [Keyframe<CGFloat>], progress: Double) -> some View {
        return self.keyframes(keyframes, progress: progress, modifier: ScaleModifier())
    }
    
    /// Create a keyframe animation of the scale of the view  by equally distributing the `values`. Use an `.animation` modifier to specify the animation.
    /// - Parameter keyframes: The scale values of the animation.
    /// - Parameter progress: The progress of the animation. Use a `@State` variable of value `0` and set to `1` to start animation.
    public func keyframes(scale values: [CGFloat], progress: Double) -> some View {
        return self.keyframes(values, progress: progress, modifier: ScaleModifier())
    }
}
