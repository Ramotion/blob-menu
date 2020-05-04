//
//  ViewSwapper.swift
//  BlobMenu
//
//  Created by Igor K. on 21.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

struct ViewSwapper<T: View, M: View>: View {
    let first: T
    let second: M
    let isFirst: Bool
    
    var body: some View {
        Group {
            if isFirst {
                first
            } else {
                second
            }
        }
    }
}


extension View {
    @ViewBuilder func add<T>(if condition: Bool, transform: (Self) -> T) -> some View where T : View {
        
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
