//
//  Compare+Extensions.swift
//  BlobMenu
//
//  Created by Igor K. on 23.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation

extension Comparable {
    
    /**
     Bound the current value between a minimum and maximum value
     
     - parameter min: The minimum possible value
     - parameter max: The maximum possible value
     
     - returns: The current value bounded between a minimum and maximum value
    */
    func limited(min: Self, max: Self) -> Self {
        var value = self
        value.limit(min: min, max: max)
        return value
    }
    
    /**
     Bound the current value between a minimum and maximum value
     
     - parameter min: The minimum possible value
     - parameter max: The maximum possible value
     
     - returns: The current value bounded between a minimum and maximum value
     */
    func limited(_ min: Self, _ max: Self) -> Self {
        return limited(min: min, max: max)
    }
    
    /**
     Bound self between a minimum and maximum value, in place
     
     - parameter min: The minimum possible value
     - parameter max: The maximum possible value
     */
    mutating func limit(min: Self, max: Self) {
        self = Swift.max(Swift.min(self, max), min)
    }
}
