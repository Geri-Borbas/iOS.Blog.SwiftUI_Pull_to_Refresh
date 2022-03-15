//
//  RefreshControl.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 26..
//

import SwiftUI
import Combine


struct ScrollViewResolver: UIViewRepresentable {
    
    let onResolve: (UIScrollView) -> Void
    
    func makeCoordinator() -> ScrollViewResolverCoordinator {
        ScrollViewResolverCoordinator()
    }
    
    func makeUIView(context: Context) -> UIView {
        print("RefreshControl.\(#function)")
        let view = UIView(frame: .zero)
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        
        // Only if not resolved yet.
        guard context.coordinator.scrollView == nil else { return }
        
        // Lookup view ancestry for any `UIScrollView`.
        if let scrollView = view.searchViewAnchestors(for: UIScrollView.self) {
            print("🎉")
            self.onResolve(scrollView)
            context.coordinator.scrollView = scrollView
        }
    }
}

class ScrollViewResolverCoordinator: NSObject {
    
    var scrollView: UIScrollView?
}


// MARK: - Extensions

extension UIRefreshControl {
    
    /// Convinience method to assign target action inline.
    func withTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> UIRefreshControl {
        self.addTarget(target, action: action, for: controlEvents)
        return self
    }
    
    /// Convinience method to assign target action inline.
    func testable(as id: String) -> UIRefreshControl {
        self.isAccessibilityElement = true
        self.accessibilityIdentifier = id
        return self
    }
}


fileprivate extension UIView {
    
    /// Search ancestral view hierarcy for the given view type.
    func searchViewAnchestors<ViewType: UIView>(for viewType: ViewType.Type) -> ViewType? {
        if let matchingView = self.superview as? ViewType {
            return matchingView
        } else {
            return superview?.searchViewAnchestors(for: viewType)
        }
    }
}
