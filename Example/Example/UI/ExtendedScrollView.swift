//
//  ExtendedScrollView.swift
//  Example
//
//  Created by Igor K. on 19.05.2020.
//  Copyright © 2020 Ramotion. All rights reserved.
//

import Foundation
import SwiftUI

struct ExtendedScrollView: UIViewRepresentable {

    private let isDragging: Binding<Bool>
    private let scrollView = UIScrollView()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(control: self, isDragging: isDragging)
    }

    func makeUIView(context: Context) -> UIScrollView {
        scrollView.delegate = context.coordinator
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }

    init<Content: View>(axis: Axis = .vertical,
                        isDragging: Binding<Bool> = .constant(false),
                        showsIndicators: Bool = false,
                        alwaysBounce: Bool = true,
                        contentInset: UIEdgeInsets = .zero,
                        @ViewBuilder content: () -> Content) {
        
        self.isDragging = isDragging
        
        let hosting = UIHostingController(rootView: content())
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        hosting.view.backgroundColor = .clear
        hosting.edgesForExtendedLayout = .all
        hosting.extendedLayoutIncludesOpaqueBars = true
        
        scrollView.addSubview(hosting.view)
        scrollView.showsVerticalScrollIndicator = showsIndicators
        scrollView.showsHorizontalScrollIndicator = showsIndicators
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = contentInset
        scrollView.contentOffset = .zero
        scrollView.backgroundColor = .clear
        
        let constraints: [NSLayoutConstraint]
        switch axis {
        case .horizontal:
            scrollView.alwaysBounceHorizontal = alwaysBounce
            
            constraints = [
                hosting.view.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                hosting.view.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                hosting.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
                hosting.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                hosting.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            ]
        case .vertical:
            scrollView.alwaysBounceVertical = alwaysBounce
            
            constraints = [
                hosting.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                hosting.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                hosting.view.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                hosting.view.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
                hosting.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ]
        }
        scrollView.addConstraints(constraints)
    }
    
    final class Coordinator: NSObject, UIScrollViewDelegate {
        private let isDragging: Binding<Bool>
        private let control: ExtendedScrollView

        init(control: ExtendedScrollView, isDragging: Binding<Bool>) {
            self.control = control
            self.isDragging = isDragging
        }
        
        //MARK: - UIScrollView delegate methods
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            isDragging.wrappedValue = true
        }

        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            isDragging.wrappedValue = false
        }
    }
}
