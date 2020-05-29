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
            VStack(alignment: .leading) {
                Image("Logo")
                    .padding(.leading, 40)
                
                Text("SwiftUI Blob Menu")
                    .font(Font.system(size: 24, weight: Font.Weight.semibold))
                    .foregroundColor(.contrastTextColor)
                    .lineLimit(1)
                    .padding(.top, 110)
                    .padding(.horizontal, 40)
                
                Text("Open the menu by tapping on the hamburger. To close the menu, just tap outside. In this example, by tapping on the menu you will switch the screen view, but it can be used for other purposes. In code you can update the configuration to the close menu after item has been selected.")
                    .font(Font.system(size: 16))
                    .foregroundColor(.contrastInformationColor)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 24)
                    .padding(.horizontal, 40)
                
                Spacer()
            }
            .frame(maxHeight: 400)
        }
    }
}
