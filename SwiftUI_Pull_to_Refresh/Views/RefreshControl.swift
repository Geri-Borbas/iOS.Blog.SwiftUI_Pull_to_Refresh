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
        print("RefreshControl.makeCoordinator()")
        return RefreshControlCoordinator(isRefreshing: self.isRefreshing, onValueChanged: self.onValueChanged)
    }
    
    func makeUIView(context: Context) -> UIView {
        print("RefreshControl.makeUIView()")
        return UIView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        print("RefreshControl.updateUIView()")
        if isRefreshing.wrappedValue == false {
            context.coordinator.refreshControl?.endRefreshing()
        }
        context.coordinator.addRefreshControlIfNeeded(for: uiView)
    }
}


/// An `NSObject` that communicates with the `UIRefreshControl` instance.
class RefreshControlCoordinator: NSObject {
    
    let isRefreshing: Binding<Bool>
    let onValueChanged: () -> Void
    
    weak var refreshControl: UIRefreshControl?
    
    init(isRefreshing: Binding<Bool>, onValueChanged: @escaping () -> Void) {
        self.isRefreshing = isRefreshing
        self.onValueChanged = onValueChanged
    }
    
    /// Adds a `UIRefreshControl` to the first `UIScrollView` found amongst the ancestor views.
    func addRefreshControlIfNeeded(for view: UIView) {
        if self.refreshControl == nil {
            view.searchViewAnchestorsFor { (scrollView: UIScrollView) in
                scrollView.refreshControl = UIRefreshControl().withTarget(
                    self,
                    action: #selector(self.onValueChangedAction),
                    for: .valueChanged
                )
                self.refreshControl = scrollView.refreshControl
            }
        }
    }
    
    @objc func onValueChangedAction() {
        self.isRefreshing.wrappedValue = true
        self.onValueChanged()
    }
    
    func endRefreshing() {
        self.isRefreshing.wrappedValue = false
        self.refreshControl?.endRefreshing()
    }
}


// MARK: - Extensions

extension UIRefreshControl {
    
    /// Convinience method to assign target action inline.
    func withTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> UIRefreshControl {
        self.addTarget(target, action: action, for: controlEvents)
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
