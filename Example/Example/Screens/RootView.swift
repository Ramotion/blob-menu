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
    
    //You can use blob menu as simple observable object
    //@ObservedObject private var blobMenuModel = BlobMenuModel(items:  BlobMenuItem.all)
    
    //Or by using it as environment object
    @EnvironmentObject var blobMenuModel: BlobMenuModel
    
    
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
        case .wallet: return FirstView().asAnyView
        case .exchange: return SecondView().asAnyView
        case .commerce: return ThirdView().asAnyView
        case .stocks: return FourthView(isDragging: $isDragging.animatable).asAnyView
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
