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
    
    @Binding var isDragging: Bool
    
    var body: some View {
        NavigationView {
            ExtendedScrollView(isDragging: $isDragging, contentInset: Theme.contentInset) {
                ForEach(0..<10) { index in
                    ItemCell()
                }
            }
            .navigationBarTitle("Wallet", displayMode: .inline)
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


//MARK: - Theme
extension WalletView {
    enum Theme {
        static let contentInset = UIEdgeInsets(top: 20, left: 0, bottom: UIWindow.safeInsets.bottom + 20, right: 0)
    }
}
