//
//  Utilities.swift
//  Example
//
//  Created by Igor K. on 05.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI


extension Binding where Value == Bool {
    var animatable: Binding<Bool>  {
        return Binding<Bool>(get: { return self.wrappedValue },
                              set: { b in withAnimation { self.wrappedValue = b } })
    }
}
