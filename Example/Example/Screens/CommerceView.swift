//
//  CommerceView.swift
//  Example
//
//  Created by Igor K. on 20.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI

struct CommerceView: View {
    var body: some View {
        Screen(color: .background) {
            VStack {
                self.avatar
                self.name
                self.info
            }
        }
    }
    
    private var avatar: some View {
        ZStack {
            Color.background
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.stroke, lineWidth: 0.5))
                .frame(size: CGSize(uniform: 60))
                .shadow(color: Color.shadow, radius: 7, y: 3)
            RandomIcon()
        }
    }
    
    private var name: some View {
        Text(Lorem.words(3).capitalized)
            .font(.subheadline)
            .foregroundColor(.textColor)
            .lineLimit(1)
            .padding(.top, 40)
            .padding(.horizontal)
    }
    
    private var info: some View {
        Text(Lorem.sentences(3))
            .font(.body)
            .foregroundColor(.contrastInformationColor)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.all)
    }
}

struct CommerceView_Previews: PreviewProvider {
    static var previews: some View {
        CommerceView()
    }
}
