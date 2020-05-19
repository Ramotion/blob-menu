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

    private let axis: Axis
    private let scrollView = UIScrollView()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(control: self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl), for: .valueChanged)
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) { }

    init<Content: View>(axis: Axis, @ViewBuilder content: () -> Content) {
        self.axis = axis
        
        let hosting = UIHostingController(rootView: content())
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(hosting.view)
        
        let constraints: [NSLayoutConstraint]
        switch self.axis {
        case .horizontal:
            constraints = [
                hosting.view.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                hosting.view.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                hosting.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
                hosting.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                hosting.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            ]
        case .vertical:
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
    
    final class Coordinator: NSObject {
        let control: ExtendedScrollView

        init(control: ExtendedScrollView) {
            self.control = control
        }

        @objc fileprivate func handleRefreshControl(sender: UIRefreshControl) {
            // handle the refresh event
            sender.endRefreshing()
        }
    }
}
