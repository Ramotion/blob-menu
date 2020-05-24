//
//  ThirdView.swift
//  Example
//
//  Created by Igor K. on 20.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI
import BlobMenu

struct ThirdView: View {

    @Environment(\.menuEnvironment) private var menuModel: BlobMenuModel
    
    var body: some View {
        Screen(color: .background) {
            VStack {
                logo
                self.title
                self.info
                
                HStack(spacing: 50) {
                    Button("Remove") { self.menuModel.items = BlobMenuItem.standard }
                    Button("Add") { self.menuModel.items = BlobMenuItem.extended }
                }.padding(.top, 40)
            }
        }
    }
    
    private var title: some View {
        Text("SwiftUI Blob Menu")
            .font(.subheadline)
            .foregroundColor(.textColor)
            .lineLimit(1)
            .padding(40)
    }
    
    private var info: some View {
        Text("Menu supports dynamically items count update. If UI can't be layout to show all items simultaneously they will be wrapperd in scroll view.")
            .font(.footnote)
            .foregroundColor(.contrastInformationColor)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 40)
    }
}
