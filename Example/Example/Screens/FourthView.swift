//
//  FourthView.swift
//  Example
//
//  Created by Igor K. on 20.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI

private let cardHeight: CGFloat = 156

struct FourthView: View {
        
    @Binding var isDragging: Bool
    
    var body: some View {
        let v = (UIScreen.main.bounds.height - cardHeight) / 2
        let vd: CGFloat = 50
        let insets = UIEdgeInsets(top: v - vd, left: 0, bottom: v + vd, right: 0)
        
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
                    .padding(.bottom, UIScreen.main.bounds.height < 800 ? 50 : 0)
                }
                .frame(maxHeight: 500)
                
                ExtendedScrollView(isDragging: self.$isDragging, contentInset: insets) {
                    ItemCell().background(Color.clear)
                }
            }
        }
    }
}

private struct ItemCell: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Drag scroll view")
                .font(Font.system(size: 24, weight: Font.Weight.semibold))
                .foregroundColor(Color.contrastText)
                .lineLimit(1)
                .padding(Edge.Set.all.subtracting(.bottom))
            
            Text("This is example shows how you can hide the menu while the user is interacting with other UI.")
                .font(Font.system(size: 16))
                .lineSpacing(6)
                .foregroundColor(Color.contrastInformation)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.trailing, 60)
                .padding(Edge.Set.all.subtracting(.trailing))
        }
        .frame(height: cardHeight)
        .background(Color.cardBackgound)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: Color.shadow, radius: 7, y: 3)
        .padding(EdgeInsets(top: 7, leading: 15, bottom: 7, trailing: 15))
    }
}
