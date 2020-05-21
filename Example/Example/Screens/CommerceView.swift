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
        VStack {
            avatar
            name
            info
        }
    }
    
    private var avatar: some View {
        Color.white
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 0.5))
            .frame(size: CGSize(uniform: 50))
            .rotateAroundOnTap
            .shadow(color: Color(white: 0, opacity: 0.2), radius: 7, y: 3)
    }
    
    private var name: some View {
        Text(Lorem.words(3).capitalized)
             .font(.subheadline)
             .lineLimit(1)
             .padding(.top, 40)
             .padding(.horizontal)
    }
    
    private var info: some View {
        Text(Lorem.sentences(3))
            .font(.body)
            .foregroundColor(.gray)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.all)
    }
}

struct CommerceView_Previews: PreviewProvider {
    static var previews: some View {
        CommerceView()
    }
}
