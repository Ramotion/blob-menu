//
//  WalletView.swift
//  Example
//
//  Created by Igor K. on 05.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

struct WalletView: View {
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(0..<10) { index in
                    ItemCell()
                }
            }
            .simultaneousGesture(DragGesture(minimumDistance: 2).onChanged { g in
                print("DRAG: \(Date().timeIntervalSince1970)")
            })
            .navigationBarTitle("Wallet", displayMode: .large)
        }
    }
}


private struct ItemCell: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.random)
                .aspectRatio(5/3, contentMode: .fill)
                .layoutPriority(1)
            Text(Lorem.words(3).capitalized)
                .font(.subheadline)
                .lineLimit(1)
                .padding(Edge.Set.all.subtracting(.bottom))
            Text(Lorem.paragraph)
                .font(.body)
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.all)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8)
        .stroke(Color.gray, lineWidth: 0.5))
        .shadow(color: Color(white: 0, opacity: 0.2), radius: 7, y: 3)
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
    }
}
