//
//  ExchangeView.swift
//  Example
//
//  Created by Igor K. on 20.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI

struct ExchangeView: View {
    var body: some View {
        SwiftUIPagerView(
            pages: (0..<4).map {
                index in Page()
        })
    }
}

struct Page: View, Identifiable {
    let id = UUID()

    var body: some View {
        VStack(spacing: 0) {
            Text("Page")
        }
        .frame(width: 414, height: 300, alignment: .leading)
        .background(Color.random)
    }
}

struct ExchangeView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeView()
    }
}
