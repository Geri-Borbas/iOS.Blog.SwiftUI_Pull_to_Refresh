//
//  ContentView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 25..
//

import SwiftUI


struct ContentView: View {
    
    @State var isRefreshing: Bool = false
    
    var body: some View {
        List {
            
            // Refresh control.
            RefreshControl(isRefreshing: $isRefreshing) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.isRefreshing = false
                }
            }
            
            // Rows.
            ForEach(
                1...100,
                id: \.self,
                content: { eachRowIndex in
                    Text("Row \(eachRowIndex)")
                }
            )
            .opacity(isRefreshing ? 0.2 : 1.0)
        }
    }
}


/// SwiftUI View.
struct RefreshControl: UIViewRepresentable {
    
    let isRefreshing: Binding<Bool>
    let onValueChanged: () -> Void
    
    public func makeCoordinator() -> RefreshControlCoordinator {
        return RefreshControlCoordinator(isRefreshing: self.isRefreshing, onValueChanged: self.onValueChanged)
    }
    
    func makeUIView(context: Context) -> UIView {
        UIView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.addRefreshControlIfNeeded(for: uiView)
        if isRefreshing.wrappedValue == false {
            context.coordinator.endRefreshing()
        }
    }
}


/// A `UIView` subclass that communicates with the `UIRefreshControl` instance.
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
