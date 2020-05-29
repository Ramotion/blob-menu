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
            VStack(alignment: .leading) {
                
                Image("Logo")
                    .padding(.leading, 40)
                
                Text("Menu items")
                    .font(Font.system(size: 24, weight: Font.Weight.semibold))
                    .foregroundColor(.contrastTextColor)
                    .lineLimit(1)
                    .padding(.top, 110)
                    .padding(.horizontal, 40)
                
                Text("The menu supports dynamically updating item count. If the UI layout can’t to show all items simultaneously, they will be wrapped in a scroll view.")
                    .font(Font.system(size: 16))
                    .foregroundColor(.contrastInformationColor)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 24)
                    .padding(.horizontal, 40)
                
                HStack(spacing: 50) {
                    Button("Remove") { self.menuModel.items = BlobMenuItem.standard }
                    Button("Add") { self.menuModel.items = BlobMenuItem.extended }
                }
                .padding(.horizontal, 40)
                .padding(.top, 40)
                
                Spacer()
            }
            .frame(maxHeight: 400)
        }
    }
}
