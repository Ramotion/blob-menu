//
//  ContentView.swift
//  Example
//
//  Created by Igor K. on 16.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI
import BlobMenu

struct RootView: View {

    enum Screen: Int, CaseIterable {
        case wallet
        case exchange
        case commerce
        case stocks
    }
    
    @State private var screen: Screen = .wallet
    @State private var isDragging: Bool = false 
    
    @ObservedObject private var blobMenuModel = BlobMenuModel(items:  BlobMenuItem.all)
    
    var body: some View {
        ZStack {
            screenView.edgesIgnoringSafeArea(Edge.Set.all.subtracting(.top))
            menuView.opacity(isDragging ? 0.1 : 1)
        }
        .background(Color.background)
    }
    
    private var screenView: some View {
        let screen = Screen(rawValue: blobMenuModel.selectedIndex) ?? .wallet
        switch screen {
        case .wallet: return WalletView(isDragging: $isDragging.animatable).asAnyView
        case .exchange: return ExchangeView().asAnyView
        case .commerce: return CommerceView().asAnyView
        case .stocks: return StocksView(isDragging: $isDragging.animatable).asAnyView
        }
    }
    
    private var menuView: some View {
        VStack {
            Spacer()
            BlobMenuView(model: blobMenuModel).padding(.bottom, 30)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

extension BlobMenuItem {
    static let all: [BlobMenuItem] = [
        BlobMenuItem(selectedIcon: Image.walletSelected, unselectedIcon: Image.walletUnselected, offset: CGPoint(x: 1, y: -2)),
        BlobMenuItem(selectedIcon: Image.exchangeSelected, unselectedIcon: Image.exchangeUnselected),
        BlobMenuItem(selectedIcon: Image.bitcoinSelected, unselectedIcon: Image.bitcoinUnselected),
        BlobMenuItem(selectedIcon: Image.gridSelected, unselectedIcon: Image.gridUnselected)
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
