//
//  BackgroundView.swift
//  BlobMenu
//
//  Created by Igor K. on 27.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI


struct BackgroundPreferenceData {
    let bounds: Anchor<CGRect>
}

struct BackgroundPreferenceKey: PreferenceKey {
    typealias Value = [BackgroundPreferenceData]
    
    static var defaultValue: [BackgroundPreferenceData] = []
    
    static func reduce(value: inout [BackgroundPreferenceData], nextValue: () -> [BackgroundPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

struct BackgroundView: View {
    
    let color: Color
    
    var body: some View {
        return Rectangle()
        .fill(color)
        .anchorPreference(key: BackgroundPreferenceKey.self, value: .bounds, transform: { [BackgroundPreferenceData(bounds: $0)] })
    }
}
