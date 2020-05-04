//
//  FrameKeyframesAnimation.swift
//  BlobMenu
//
//  Created by Igor K. on 26.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

/// An example of a `AnimatableModifier` to animate the `.scale` of a `View ` in an keyframe animation.
private struct SizeModifier: AnimatableModifier {
    var animatableData: CGSize = .zero
    
    func body(content: Content) -> some View {
        return content.frame(size: animatableData)
    }
}


extension View {

    /// Create a keyframe animation of the size of the view. Use an `.animation` modifier to specify the animation.
    /// - Parameter keyframes: The array of keyframes. Does not have to be sorted.
    /// - Parameter progress: The progress of the animation. Use a `@State` variable of value `0` and set to `1` to start animation.
    public func keyframes(size keyframes: [Keyframe<CGSize>], progress: Double) -> some View {
        return self.keyframes(keyframes, progress: progress, modifier: SizeModifier())
    }
    
    /// Create a keyframe animation of the size of the view  by equally distributing the `values`. Use an `.animation` modifier to specify the animation.
    /// - Parameter keyframes: The size values of the animation.
    /// - Parameter progress: The progress of the animation. Use a `@State` variable of value `0` and set to `1` to start animation.
    public func keyframes(size values: [CGSize], progress: Double) -> some View {
        return self.keyframes(values, progress: progress, modifier: SizeModifier())
    }
}
