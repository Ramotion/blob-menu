//
//  ExchangeView.swift
//  Example
//
//  Created by Igor K. on 20.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI

struct ExchangeView: View {
    
    @State private var currentIndex: Int = 0
    
    private let title = Text(Lorem.words(3).capitalized)
    private let description = Text(Lorem.sentences(3))
    
    var body: some View {
        Screen(color: .white) {
            VStack {
                self.title
                    .font(.subheadline)
                    .lineLimit(1)
                    .padding(.top, 80)
                    .padding(.horizontal)
                
                self.description
                    .font(.body)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.all)
                
                SwiftUIPagerView(index: self.$currentIndex.animatable, pages: self.pages)
                    .frame(height: 350)
                PageControl(pagesCount: 4, index: self.$currentIndex)
                Spacer()
            }
        }
    }
    
    private var pages: [Page] {
        return (0..<4).map { index in Page() }
    }
}

struct Page: View, Identifiable {
    let id = UUID()
    
    var body: some View {
        Color.white
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 0.5))
            .frame(height: 300)
            .shadow(color: Color(white: 0, opacity: 0.2), radius: 7, y: 3)
            .overlay(RandomIcon().padding(), alignment: .topLeading)
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
    }
}

struct ExchangeView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeView()
    }
}
