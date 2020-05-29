//
//  FourthView.swift
//  Example
//
//  Created by Igor K. on 20.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI

private let cardHeight: CGFloat = 176

struct FourthView: View {
        
    @Binding var isDragging: Bool
    
    var body: some View {
        let v = (UIScreen.main.bounds.height - cardHeight) / 2
        let insets = UIEdgeInsets(top: v, left: 0, bottom: v, right: 0)
        
        return Screen(color: .background) {
            ZStack {
                VStack(alignment: .leading) {
                    Image("Logo")
                        .padding(.leading, 40)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Image("Icon_Swipe")
                        Spacer()
                    }
                }
                .frame(maxHeight: 400)
                
                ExtendedScrollView(isDragging: self.$isDragging, contentInset: insets) {
                    ItemCell()
                }
            }
            
        }
    }
}

private struct ItemCell: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Drag card view")
                .font(Font.system(size: 24, weight: Font.Weight.semibold))
                .foregroundColor(Color.black)
                .lineLimit(1)
                .padding(Edge.Set.all.subtracting(.bottom))
            
            Text("This is example shows how you can hide the menu while the user is interacting with other UI.")
                .font(Font.system(size: 16))
                .foregroundColor(Color.black.opacity(0.6))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.trailing, 60)
                .padding(Edge.Set.all.subtracting(.trailing))
        }
        .frame(height: cardHeight)
        .background(Color.cardBackgound)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: Color.shadow, radius: 7, y: 3)
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
    }
}
