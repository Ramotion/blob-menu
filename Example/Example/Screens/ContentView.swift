//
//  ContentView.swift
//  Example
//
//  Created by Igor K. on 16.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI
import BlobMenu

struct ContentView: View {
    var body: some View {
        BlobMenuView.createMenu(items: MenuItem.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension MenuItem {
    static let all: [MenuItem] = [
        MenuItem(selectedIcon: Image.walletSelected, unselectedIcon: Image.walletUnselected, offset: CGPoint(x: 1, y: -2)),
        MenuItem(selectedIcon: Image.exchangeSelected, unselectedIcon: Image.exchangeUnselected),
        MenuItem(selectedIcon: Image.bitcoinSelected, unselectedIcon: Image.bitcoinUnselected),
        MenuItem(selectedIcon: Image.gridSelected, unselectedIcon: Image.gridUnselected)
    ]
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
