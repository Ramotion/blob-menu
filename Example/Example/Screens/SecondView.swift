//
//  SecondView.swift
//  Example
//
//  Created by Igor K. on 20.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI
import BlobMenu

struct SecondView: View {
    
    @Environment(\.menuEnvironment) private var menuModel: BlobMenuModel
    
    var body: some View {
        Screen(color: .background) {
            VStack {
                logo
                self.title
                self.info
                
                HStack(spacing: 50) {
                    Button("Close") { self.menuModel.closeMenu() }
                    Button("Open") { self.menuModel.openMenu() }
                }.padding(.top, 40)
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
        Text("Also menu can be oppened and closed programmatically.")
            .font(.footnote)
            .foregroundColor(.contrastInformationColor)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 40)
    }
}
