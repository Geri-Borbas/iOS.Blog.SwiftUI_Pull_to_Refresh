//
//  ScrollViewResolver.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI

struct ScrollViewResolver: UIViewRepresentable {
    
    @Binding var scrollView: UIScrollView?
    
    func makeUIView(context: Context) -> UIView {
        print("ScrollViewResolver.makeUIView()")
        return UIView(frame: .zero)
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        print("ScrollViewResolver.updateUIView()")
        
        // Only if not resolved yet.
        if let scrollView = self.scrollView {
            print("Already resolved scrollView: \(scrollView)")
            return
        }
        
        // Lookup view ancestry for any `UIScrollView` then callback if any.
        if let scrollView = view.searchViewAnchestors(for: UIScrollView.self) {
            print("Resolved scrollView: \(scrollView)")
            self.scrollView = scrollView
        }
    }
}

extension ScrollViewResolver {
    
    class Coordinator: NSObject {
        var scrollView: UIScrollView?
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

extension UIView {
    
    /// Search ancestral view hierarcy for the given view type.
    func searchViewAnchestors<ViewType: UIView>(for viewType: ViewType.Type) -> ViewType? {
        if let matchingView = self.superview as? ViewType {
            return matchingView
        } else {
            return superview?.searchViewAnchestors(for: viewType)
        }
    }
}
