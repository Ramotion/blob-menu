//
//  BlobMenuBackgoundEffect.swift
//  BlobMenu
//
//  Created by Igor K. on 21.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

/*
struct AnimationCompletion: GeometryEffect {
    
    /// Ratio should be in range [0...1]
    var progress: CGFloat = 0
    
    var onCompletion: () -> Void
    
    var animatableData: CGFloat {
        get { return progress }
        set { progress = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        if self.progress == 1 {
            DispatchQueue.main.async {
                self.onCompletion()
            }
        }
        
        return ProjectionTransform()
    }
}

extension View {
    func onAnimationCompleted(condition: Bool, callback: @escaping () -> Void) -> some View {
        let m = AnimationCompletion(progress: condition ? 1 : 0, onCompletion: callback)
        return AnyView(self.modifier(m))
    }
}
*/


private struct CompletionPreferenceKey: PreferenceKey {
  typealias Value = CGFloat

  static let defaultValue: CGFloat = 0

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}


private struct CompletionModifier: AnimatableModifier {
  var progress: CGFloat = 0

  var animatableData: CGFloat {
    get { progress }
    set { progress = newValue }
  }

  func body(content: Content) -> some View {
    return content.preference(key: CompletionPreferenceKey.self, value: progress)
  }
}


private final class AnimationHolder {
  var animation: Animation?
  var disablesAnimations: Bool = false
}


extension View {
    
    func onAnimationCompleted(condition: Bool, completion: @escaping () -> Void) -> some View {
        let holder = AnimationHolder()
        var completed = false
        return self
        .transaction { transaction in
            // Restore the transaction values
            transaction.animation = holder.animation
            transaction.disablesAnimations = holder.disablesAnimations
        }
        .modifier(CompletionModifier(progress: condition ? 1 : 0))
        .transaction { transaction in
            // Store transaction value before modification
            holder.animation = transaction.animation
            holder.disablesAnimations = transaction.disablesAnimations
        }
        .onPreferenceChange(CompletionPreferenceKey.self) { progress in
            if completed == false && progress >= 1 {
                completed = true
                completion()
            }
        }
    }
}
