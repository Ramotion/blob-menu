//
//  HamburgerView.swift
//  BlobMenu
//
//  Created by Igor K. on 29.04.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import SwiftUI

public struct HamburgerView: View {
    
    public let isOpened: Bool
    
    private var rotationAngle: Angle {
        return Angle(degrees: isOpened ? -90 : 0)
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: Theme.lineSpacing) {
            line
            line
            line
        }
        .frame(size: BlobMenuView.Theme.closedSize)
        .opacity(isOpened ? 0 : 1)
        .rotationEffect(rotationAngle, anchor: UnitPoint.center)
        .animation(Animation.easeInOut(duration: 0.25).delay( isOpened ? 0 : 0.2))
    }
    
    private var line: some View {
        Rectangle()
            .frame(width: Theme.lineWidth, height: Theme.lineThickness)
            .foregroundColor(Color.hamburgerColor)
            .cornerRadius(Theme.lineCornerRadius)
    }
}


//MARK: - Preview
struct HamburgerView_Previews: PreviewProvider {
    static var previews: some View {
        return HamburgerView(isOpened: false)
    }
}


//MARK: - Theme
extension HamburgerView {
    enum Theme {
        static let lineSpacing: CGFloat = 6
        static let lineThickness: CGFloat = 3
        static let lineCornerRadius: CGFloat = 1
        static let lineWidth: CGFloat = 24
    }
}
