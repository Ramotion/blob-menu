import Foundation
import SwiftUI


struct PageControl: View {
    
    @Binding private var index: Int
    private let pagesCount: Int
    private let diameter: CGFloat
    private let spacing: CGFloat
    
    private var width: CGFloat {
        return CGFloat(pagesCount) * diameter + CGFloat(pagesCount - 1) * spacing
    }
    
    private var size: CGSize {
        return CGSize(width: width, height: diameter)
    }
    
    init(diameter: CGFloat = 6,
         spacing: CGFloat = 10,
         pagesCount: Int,
         index: Binding<Int>) {
        
        self.diameter = diameter
        self.spacing = spacing
        self.pagesCount = pagesCount
        self._index = index
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: spacing) {
                ForEach(0..<pagesCount) { i in
                    Circle().fill(Color.black.opacity(self.index == i ? 1 : 0.3))
                }
            }
            .frame(size: size)
            
            
            Circle()
                .offset(CGPoint(x: getCenteredXPosition(for: self.index), y: 0))
                .fill(Color.black)
                .frame(size: size)
        }
    }
    
    private func getCenteredXPosition(for index: Int) -> CGFloat {
        let position = CGFloat(index)  * (diameter + spacing)
        let halfAlldotsWidthWithSpaces = (CGFloat(pagesCount - 1) * (diameter + spacing) + diameter) / 2.0
        return position - halfAlldotsWidthWithSpaces + diameter / 2
    }
}
