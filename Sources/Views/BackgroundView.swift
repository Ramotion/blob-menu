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
    
    var body: some View {
        return Rectangle()
        .fill(Color.backgroundColor)
        .shadow(color: Color.backgroundColor.opacity(0.45), radius: 8, x: 0, y: 4)
        .anchorPreference(key: BackgroundPreferenceKey.self, value: .bounds, transform: { [BackgroundPreferenceData(bounds: $0)] })
    }
}
