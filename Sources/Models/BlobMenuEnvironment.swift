//
//  BlobMenuEnvironment.swift
//  BlobMenu
//
//  Created by Igor K. on 23.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var blobMenuEnvironment: BlobMenuEnvironment {
        get { return self[BlobMenuEnvironmentKey.self] }
        set { self[BlobMenuEnvironmentKey.self] = newValue }
    }
}

public struct BlobMenuEnvironmentKey: EnvironmentKey {
    public static let defaultValue: BlobMenuEnvironment = BlobMenuEnvironment()
}

public final class BlobMenuEnvironment: ObservableObject {
    @Published var isOpened: Bool = false
    @Published var isMenuItemsVisible: Bool = false 
    
    fileprivate init() {}
}
