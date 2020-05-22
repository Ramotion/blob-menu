import Foundation
import SwiftUI


struct SwiftUIPagerView<Content: View & Identifiable>: View {

    @State private var index: Int = 0
    @State private var offset: CGFloat = 0
    
    private let pages: [Content]
    private let indexChanged: (Int) -> Void

    init(pages: [Content], indexChanged: @escaping (Int) -> Void) {
        self.pages = pages
        self.indexChanged = indexChanged
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(self.pages) { page in
                        page
                            .frame(width: geometry.size.width, height: nil)
                    }
                }
            }
            .content.offset(x: self.offset)
            .frame(width: geometry.size.width, height: nil, alignment: .leading)
            .gesture(DragGesture()
                .onChanged({ value in
                    self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
                })
                .onEnded({ value in
                    if abs(value.predictedEndTranslation.width) >= geometry.size.width / 2 {
                        var nextIndex: Int = (value.predictedEndTranslation.width < 0) ? 1 : -1
                        nextIndex += self.index
                        self.index = nextIndex.limited(min: 0, max: self.pages.endIndex - 1)
                        self.indexChanged(nextIndex)
                    }
                    withAnimation { self.offset = -geometry.size.width * CGFloat(self.index) }
                })
            )
        }
    }
}
