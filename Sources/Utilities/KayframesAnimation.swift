//
//  KayframesAnimation.swift
//  BlobMenu
//
//  Created by Igor K. on 26.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

/// One keyframe in the animation.
public struct Keyframe<V: VectorArithmetic>: Equatable {
    
    /// The value of the keyfame.
    public let value: V
    
    /// The point in time where the  `value` is reached, must be in range [0, 1].
    public let progress: Double
    
    /// Initialize with a value and progress.
    public init(value: V, progress: Double) {
        self.value = value
        self.progress = progress
    }
}

public struct KeyframeModifier<M: AnimatableModifier>: AnimatableModifier {
    
    /// The array of keyframes.
    public let keyframes: [Keyframe<M.AnimatableData>]
    
    
    /// The `AnimatableModifier`.
    public let modifier: M
    
    
    /// The current progress. Must be in range [0, 1].
    private var progress: Double
    
    
    public var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    /// Initialize a new `KeyframeModifier`.
    /// - Parameter keyframes: An array of the keyframes. Does not have to be sorted.
    /// - Parameter modifier: The modifier used to apply the changes.
    /// - Parameter progress: The progress of the animation. Use a `@State` variable of value `0` and set to `1` to start animation.
    public init(keyframes: [Keyframe<M.AnimatableData>], modifier: M, progress: Double) {
        self.keyframes = keyframes.sorted(by: { $0.progress <= $1.progress })
        self.modifier = modifier
        self.progress = progress
    }
    
    /// Initialize a new `KeyframeModifier`.
    /// - Parameter keyframes: An array of values which will be used as equally distributed keyframes.
    /// - Parameter modifier: The modifier used to apply the changes.
    /// - Parameter progress: The progress of the animation. Use a `@State` variable of value `0` and set to `1` to start animation.
    public init(values: [M.AnimatableData], modifier: M, progress: Double) {
        let frames = values.enumerated()
            .map { Keyframe(value: $1, progress: 1 / Double(values.count - 1) * Double($0)) }
        self.init(keyframes: frames, modifier: modifier, progress: progress)
    }
    
    public func body(content: Content) -> some View {
        let progress = min(max(self.progress, 0), 1)
        let prev = keyframes.last(where: { $0.progress <= progress })!
        let next = keyframes.first(where: { $0.progress >= progress })!
        var m = modifier
        
        if prev != next {
            let factor = 1 / (next.progress - prev.progress)
            var val1 = next.value
            val1.scale(by: (progress - prev.progress) * factor)
            
            var val2 = prev.value
            val2.scale(by: (next.progress - progress) * factor)
            
            m.animatableData = val1 + val2
        } else {
            m.animatableData = prev.value
        }
        return content.modifier(m)
    }
}

extension View {
    
    /// Creates a keyframe animation. Use an `.animation` modifier to specify the animation.
    /// - Parameter keyframes: The array of keyframes. Does not have to be sorted.
    /// - Parameter progress: The progress of the animation. Use a `@State` variable of value `0` and set to `1` to start animation.
    /// - Parameter modifier: The modifier used to apply the changes.
    public func keyframes<M: AnimatableModifier>(_ keyframes: [Keyframe<M.AnimatableData>],
                                          progress: Double,
                                          modifier: M) -> some View {
        return self.modifier(KeyframeModifier(keyframes: keyframes, modifier: modifier, progress: progress))
    }
    
    /// Creates a keyframe animation by equally distributing the `values`. Use an `.animation` modifier to specify the animation.
    /// - Parameter values: The values of the animation.
    /// - Parameter progress: The progress of the animation. Use a `@State` variable of value `0` and set to `1` to start animation.
    /// - Parameter modifier: The modifier used to apply the changes.
    public func keyframes<M: AnimatableModifier>(_ values: [M.AnimatableData],
                                          progress: Double,
                                          modifier: M) -> some View {
        return self.modifier(KeyframeModifier(values: values, modifier: modifier, progress: progress))
    }
}
