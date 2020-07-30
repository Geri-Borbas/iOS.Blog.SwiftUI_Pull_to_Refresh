//
//  RefreshControl.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 30..
//

import SwiftUI
import Combine

class RefreshControl: ObservableObject, ScrollViewConsumer {
    
    weak var scrollView: UIScrollView? {
        didSet {
            if let scrollView = scrollView {
                self.add(to: scrollView)
            }
        }
    }
    
    /// Adds (and stores) a `UIRefreshControl` to the `UIScrollView` provided.
    func add(to scrollView: UIScrollView) {
        print("RefreshControl.\(#function)")
        print("scrollView: \(scrollView)")
    }
}
