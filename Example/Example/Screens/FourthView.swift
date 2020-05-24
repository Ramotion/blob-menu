//
//  FourthView.swift
//  Example
//
//  Created by Igor K. on 20.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI

struct FourthView: View {
        
    @Binding var isDragging: Bool
    
    var body: some View {
        let insets = UIEdgeInsets(top: 20, left: 0, bottom: 60, right: 0)
        
        return Screen(color: .background) {
            ExtendedScrollView(isDragging: self.$isDragging, contentInset: insets) {
                ItemCell()
            }
        }
    }
}

private struct ItemCell: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.background)
                .aspectRatio(2, contentMode: .fill)
                .layoutPriority(1)
                .overlay(Image("Logo"))
            Text("Drag scroll view")
                .font(.subheadline)
                .foregroundColor(.textColor)
                .lineLimit(1)
                .padding(Edge.Set.all.subtracting(.bottom))
            Text("This is example how you can hide menu during user is interacting with other UI.")
                .font(.footnote)
                .foregroundColor(.contrastInformationColor)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.trailing, 60)
                .padding(Edge.Set.all.subtracting(.trailing))
        }
        .background(Color.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8)
        .stroke(Color.stroke, lineWidth: 0.5))
        .shadow(color: Color.shadow, radius: 7, y: 3)
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
    }
}
