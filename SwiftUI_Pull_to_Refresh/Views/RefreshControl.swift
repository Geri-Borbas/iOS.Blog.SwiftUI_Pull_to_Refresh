//
//  RefreshControl.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 26..
//

import SwiftUI


struct RefreshControl: UIViewRepresentable {
    
    let isRefreshing: Binding<Bool>
    let onValueChanged: () -> Void
        
    public func makeCoordinator() -> RefreshControlCoordinator {
        print("RefreshControl.\(#function)")
        return RefreshControlCoordinator(isRefreshing: self.isRefreshing, onValueChanged: self.onValueChanged)
    }
    
    func makeUIView(context: Context) -> UIView {
        print("RefreshControl.\(#function)")
        return UIView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        print("RefreshControl.\(#function)")
        if isRefreshing.wrappedValue == false {
            let refreshControl = context.coordinator.refreshControl(for: uiView)
            print("refreshControl = \(String(describing: refreshControl))")
            refreshControl?.endRefreshing()
        }
    }
}


/// An `NSObject` that communicates with the `UIRefreshControl` instance.
class RefreshControlCoordinator: NSObject {
    
    let isRefreshing: Binding<Bool>
    let onValueChanged: () -> Void
    
    private weak var refreshControl: UIRefreshControl?
    
    init(isRefreshing: Binding<Bool>, onValueChanged: @escaping () -> Void) {
        print("RefreshControlCoordinator.\(#function)")
        self.isRefreshing = isRefreshing
        self.onValueChanged = onValueChanged
    }
    
    /// Lazily adds (and returns) a `UIRefreshControl` to the first
    /// `UIScrollView` found amongst the ancestor views if needed.
    func refreshControl(for view: UIView) -> UIRefreshControl? {
        if self.refreshControl == nil {
            view.searchViewAnchestorsFor { (scrollView: UIScrollView) in
                scrollView.refreshControl = UIRefreshControl().withTarget(
                    self,
                    action: #selector(self.onValueChangedAction),
                    for: .valueChanged
                ).testable(as: "RefreshControl")
                self.refreshControl = scrollView.refreshControl
            }
        }
        return self.refreshControl
    }
    
    @objc func onValueChangedAction() {
        print("RefreshControlCoordinator.\(#function)")
        self.isRefreshing.wrappedValue = true
        self.onValueChanged()
    }
    
    func endRefreshing() {
        print("RefreshControlCoordinator.\(#function)")
        self.isRefreshing.wrappedValue = false
        self.refreshControl?.endRefreshing()
    }
    
    deinit {
        print("RefreshControlCoordinator.\(#function)")
    }
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
}
