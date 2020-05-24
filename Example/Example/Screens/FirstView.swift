//
//  FirstView.swift
//  Example
//
//  Created by Igor K. on 05.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

struct FirstView: View {
    
    var body: some View {
        Screen(color: .background) {
            VStack {
                logo
                self.title
                self.info
            }
        }
    }
    
    private var title: some View {
        Text("SwiftUI Blob Menu")
            .font(.subheadline)
            .foregroundColor(.contrastTextColor)
            .lineLimit(1)
            .padding(40)
    }
    
    private var info: some View {
        Text("Open menu by tapping on hamburger. To close menu just tap outside. In this example by tapping on menu you will switch screen view, but it can be used for other purposes. In code you can update configuration to close menu after item has been selected.")
            .font(.footnote)
            .foregroundColor(.contrastInformationColor)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 40)
    }
}
