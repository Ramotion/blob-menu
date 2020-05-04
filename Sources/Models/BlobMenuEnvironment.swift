//
//  BlobMenuEnvironment.swift
//  BlobMenu
//
//  Created by Igor K. on 23.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

public extension EnvironmentValues {
    var blobMenuEnvironment: BlobMenuEnvironment {
        get { return self[BlobMenuEnvironmentKey.self] }
        set { self[BlobMenuEnvironmentKey.self] = newValue }
    }
}

struct BlobMenuEnvironmentKey: EnvironmentKey {
    static let defaultValue: BlobMenuEnvironment = BlobMenuEnvironment()
}

public final class BlobMenuEnvironment: ObservableObject {
    @Published public internal(set) var isOpened: Bool = false
    @Published public internal(set) var isMenuItemsVisible: Bool = false
    @Published public internal(set) var selectedIndex: Int = 0
    
    fileprivate init() {}
}
