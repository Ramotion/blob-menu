//
//  UIGestureRecognizer+Extensions.swift
//  BlobMenu
//
//  Created by Igor K. on 23.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import UIKit

extension UIGestureRecognizer {
    private class GestureAction {
        var action: (UIGestureRecognizer) -> Void

        init(action: @escaping (UIGestureRecognizer) -> Void) {
            self.action = action
        }
    }
    
    private struct AssociatedKeys {
        static var ActionName = "action"
    }

    private var gestureAction: GestureAction? {
        set { objc_setAssociatedObject(self, &AssociatedKeys.ActionName, newValue, .OBJC_ASSOCIATION_RETAIN) }
        get { return objc_getAssociatedObject(self, &AssociatedKeys.ActionName) as? GestureAction }
    }

    /**
     Convenience initializer, associating an action closure with the gesture recognizer (instead of the more traditional target/action).

     - parameter action: The closure for the recognizer to execute. There is no pre-logic to conditionally invoke the closure or not (e.g. only invoke the closure if the gesture recognizer is in a particular state). The closure is merely invoked directly; all handler logic is up to the closure.

     - returns: The UIGestureRecognizer.
     */
    public convenience init(action: @escaping (UIGestureRecognizer) -> Void) {
        self.init()
        gestureAction = GestureAction(action: action)
        addTarget(self, action: #selector(handleAction(_:)))
    }

    @objc private dynamic func handleAction(_ recognizer: UIGestureRecognizer) {
        gestureAction?.action(recognizer)
    }
}


extension UIGestureRecognizer {
    
    public var isActive: Bool {
        return isEnabled && (state == .changed || state == .began)
    }
}


extension UIView {

    public enum GestureType {
        case tap
        case longPress
        case pan
        case swipe(UISwipeGestureRecognizer.Direction)
        case tapCount(Int)
    }

    public func addGesture(type: GestureType, callback: @escaping (UIGestureRecognizer) -> Void) {
        switch type {
        case .tap:
            addGestureRecognizer(UITapGestureRecognizer(action: callback))
        case let .tapCount(count):
            addGestureRecognizer(UITapGestureRecognizer(action: callback).then { $0.numberOfTapsRequired = count })
        case .longPress:
            addGestureRecognizer(UILongPressGestureRecognizer(action: callback))
        case .pan:
            addGestureRecognizer(UIPanGestureRecognizer(action: callback))
        case let .swipe(direction):
            addGestureRecognizer(UISwipeGestureRecognizer(action: callback).then { $0.direction = direction })
        }
    }
}
