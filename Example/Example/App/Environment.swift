//
//  Environment.swift
//  Example
//
//  Created by Igor K. on 24.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI
import BlobMenu


extension EnvironmentValues {
    var menuEnvironment: BlobMenuModel {
        get { return self[MenuEnvironmentKey.self] }
        set { self[MenuEnvironmentKey.self] = newValue }
    }
}

struct MenuEnvironmentKey: EnvironmentKey {
    static let defaultValue = BlobMenuModel(items: BlobMenuItem.standard)
}

extension BlobMenuItem {
    static let standard: [BlobMenuItem] = [
        BlobMenuItem(selectedIcon: Image.walletSelected, unselectedIcon: Image.walletUnselected, offset: CGPoint(x: 1, y: -2)),
        BlobMenuItem(selectedIcon: Image.exchangeSelected, unselectedIcon: Image.exchangeUnselected),
        BlobMenuItem(selectedIcon: Image.bitcoinSelected, unselectedIcon: Image.bitcoinUnselected),
    ]
    
    static let extended: [BlobMenuItem] =
        standard + [BlobMenuItem(selectedIcon: Image.gridSelected, unselectedIcon: Image.gridUnselected)]
}


extension Image {
    static let walletSelected = Image("Icon_Wallet_black")
    static let walletUnselected = Image("Icon_Wallet_gray")
    static let bitcoinSelected = Image("Icon_Bitcoin_black")
    static let bitcoinUnselected = Image("Icon_Bitcoin_gray")
    static let exchangeSelected = Image("Icon_Exchange_black")
    static let exchangeUnselected = Image("Icon_Exchange_gray")
    static let gridSelected = Image("Icon_Grid_black")
    static let gridUnselected = Image("Icon_Grid_gray")
}
