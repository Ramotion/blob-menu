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

    enum Screen: Int {
        case wallet
        case exchange
        case commerce
        case stocks
    }
    
    @State var screen: Screen = .wallet
    @Environment(\.blobMenuEnvironment) var menuEnvironment: BlobMenuEnvironment
    
    var body: some View {
        ZStack {
            screenView.edgesIgnoringSafeArea(Edge.Set.all)
            menuView
        }
    }
    
    private var screenView: some View {
        switch screen {
        case .wallet: return Rectangle().fill(Color.random)
        case .exchange: return Rectangle().fill(Color.random)
        case .commerce: return Rectangle().fill(Color.random)
        case .stocks: return Rectangle().fill(Color.random)
        }
    }
    
    private var menuView: some View {
        VStack {
            Spacer()
            BlobMenuView.createMenu(items: MenuItem.all, selectedIndex: self.screen.rawValue).padding(.bottom, 30)
        }.onReceive(menuEnvironment.$selectedIndex) { index in
            guard let screen = Screen(rawValue: index) else { return }
            self.screen = screen
        }
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


extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}
