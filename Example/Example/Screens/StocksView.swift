//
//  StocksView.swift
//  Example
//
//  Created by Igor K. on 20.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI

struct StocksView: View {
    
    @Binding var isDragging: Bool
    
    var body: some View {
        NavigationView {
            ExtendedScrollView(isDragging: $isDragging, contentInset: Theme.contentInset) {
                VStack(spacing: Theme.padding) {
                    verticalCollection
                    horizontalCollection
                    verticalCollection
                }
            }
            .navigationBarTitle("Stocks", displayMode: .inline)
        }
    }
    
    private var verticalCollection: some View {
        GridStack(columns: 4, rows: 2, spacing: Theme.padding) { row, col in
            self.cell(size: Theme.cellSize)
        }
    }
    
    private var horizontalCollection: some View {
        ExtendedScrollView(axis: .horizontal, isDragging: $isDragging, contentInset: Theme.horizontalContentInset) {
            HStack(spacing: Theme.padding) {
                ForEach(0..<10) { index in
                    self.cell(size: Theme.horizontalCellSize).padding(.vertical, 20)
                }
            }
        }.frame(height: Theme.horizontalCellSize.height + 40)
    }
    
    private func cell(size: CGSize) -> some View {
        ZStack {
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
                .frame(size: size)
                .shadow(color: Color(white: 0, opacity: 0.2), radius: 7, y: 3)
            Text(Lorem.words(1).capitalized)
                .font(.body)
                .foregroundColor(Color.primary.opacity(0.45))
                .lineLimit(1)
                .greedyFrame(alignment: .bottomLeading)
                .padding()
        }
    }
}

struct StocksView_Previews: PreviewProvider {
    static var previews: some View {
        StocksView(isDragging: .constant(false))
    }
}


//MARK: - Theme
extension StocksView {
    enum Theme {
        static let padding: CGFloat = 20
        static private let w = (UIScreen.main.bounds.width - padding * 3) / 2
        
        static var horizontalCellSize: CGSize {
            let h = floor(w * 0.5)
            return CGSize(width: w, height: h)
        }
        
        static var cellSize: CGSize {
            let w = (UIScreen.main.bounds.width - padding * 3) / 2
            let h = floor(w * 1.25)
            return CGSize(width: w, height: h)
        }
        
        static let contentInset = UIEdgeInsets(top: 20, left: 0, bottom: UIWindow.safeInsets.bottom + 20, right: 0)
        
        static let horizontalContentInset = UIEdgeInsets(horizontal: 20, vertical: 0)
    }
}
