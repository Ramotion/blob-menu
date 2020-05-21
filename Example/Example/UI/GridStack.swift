//
//  GridStack.swift
//  Example
//
//  Created by Igor K. on 05.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI


public struct GridStack<Content: View>: View {
    let columns: Int
    let rows: Int
    let spacing: CGFloat
    let content: (Int, Int) -> Content
    
    public init(columns: Int, rows: Int, spacing: CGFloat = 0, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.columns = columns
        self.rows = rows
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing: self.spacing) {
            ForEach(0..<self.rows, id: \.self) { row in
                HStack(spacing: self.spacing) {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(column, row)
                    }
                }
            }
        }
    }
}
