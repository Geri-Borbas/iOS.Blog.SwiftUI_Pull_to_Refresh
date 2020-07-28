//
//  RefreshControl.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 26..
//

import SwiftUI
import Combine

class RefreshControl: ObservableObject {
    
    var onValueChanged: (() -> Void)?
    @Published /* private(set) */ var isRefreshing: Bool = false
    
    private weak var refreshControl: UIRefreshControl?
    private var subscribers: Set<AnyCancellable> = []
    
    func add(onValueChanged: @escaping () -> Void) {
        self.onValueChanged = onValueChanged
    }
    
    init() {
        $isRefreshing.removeDuplicates().sink { (isRefreshing: Bool) in
            if isRefreshing == false {
                self.refreshControl?.endRefreshing()
            }
        }.store(in: &subscribers)
    }
    
    /// Adds (and stores) a `UIRefreshControl` to the `UIScrollView` provided.
    func add(to scrollView: UIScrollView) {
        print("RefreshControl.\(#function)")
        
        // Only if not added already.
        guard self.refreshControl == nil else { return }
        
        // Create then add to scroll view.
        scrollView.refreshControl = UIRefreshControl().withTarget(
            self,
            action: #selector(self.onValueChangedAction),
            for: .valueChanged
        ).testable(as: "RefreshControl")
        
        // Reference (weak).
        self.refreshControl = scrollView.refreshControl
    }
    
    @objc private func onValueChangedAction() {
        print("RefreshControl.\(#function)")
        self.isRefreshing = true
        self.onValueChanged?()
    }
    
    deinit {
        print("RefreshControlCoordinator.\(#function)")
        subscribers.removeAll()
    }
}


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
        view.searchViewAnchestorsFor { (scrollView: UIScrollView) in
            print("view.searchViewAnchestorsFor(scrollView: \(scrollView)")
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


extension UIView {
    
    /// Search ancestral view hierarcy for the given view type.
    func searchViewAnchestorsFor<ViewType: UIView>(
        _ onViewFound: (ViewType) -> Void
    ) {
        if let matchingView = self.superview as? ViewType {
            onViewFound(matchingView)
        } else {
            superview?.searchViewAnchestorsFor(onViewFound)
        }
    }
    
    func printViewHierarchyInformation(_ level: Int = 0) {
        printViewInformation(level)
        self.subviews.forEach { $0.printViewHierarchyInformation(level + 1) }
    }
        
    func printViewInformation(_ level: Int) {
        let leadingWhitespace = String(repeating: "  ", count: level)
        let className = "\(Self.self)"
        let superclassName = "\(self.superclass!)"
        print("\(leadingWhitespace)\(className): \(superclassName)")
    }
}
