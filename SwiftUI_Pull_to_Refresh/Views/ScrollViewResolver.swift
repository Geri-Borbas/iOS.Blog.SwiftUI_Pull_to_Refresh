//
//  ScrollViewResolver.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI

struct ScrollViewResolver: UIViewRepresentable {
    
    let refreshControl: RefreshControl
    
    func makeUIView(context: Context) -> UIView {
        print("ScrollViewResolver.makeUIView()")
        return UIView(frame: .zero).testable(as: "ScrollViewResolver")
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        print("ScrollViewResolver.updateUIView()")
        
        // Only if not resolved yet.
        if let scrollView = refreshControl.scrollView {
            print("Already resolved scrollView: \(scrollView)")
            return
        }
        
        // Lookup view ancestry for any `UIScrollView` then callback if any.
        if let scrollView = view.searchViewAnchestors(for: UIScrollView.self) {
            print("Resolved scrollView: \(scrollView)")
            refreshControl.scrollView = scrollView
        }
    }
}

extension UIView {
    
    /// Search ancestral view hierarchy for the given view type.
    func searchViewAnchestors<ViewType: UIView>(for viewType: ViewType.Type) -> ViewType? {
        if let matchingView = self.superview as? ViewType {
            return matchingView
        } else {
            return superview?.searchViewAnchestors(for: viewType)
        }
    }
    
    /// Convinience.
    func testable(as id: String) -> Self {
        self.isAccessibilityElement = true
        self.accessibilityIdentifier = id
        return self
    }
}
