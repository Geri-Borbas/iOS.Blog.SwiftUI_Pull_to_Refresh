//
//  _RefreshControl.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 30..
//

import SwiftUI
import Combine

class _RefreshControl: ObservableObject, ScrollViewConsumer {
    
    weak var scrollView: UIScrollView? {
        didSet {
            if let scrollView = scrollView {
                self.add(to: scrollView)
            }
        }
    }
    
    weak var refreshControl: UIRefreshControl?
    var onValueChanged: (() -> Void)?
    
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
        self.onValueChanged?()
    }
}
