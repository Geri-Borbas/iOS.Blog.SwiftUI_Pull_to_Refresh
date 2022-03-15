//
//  ContentView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 25..
//

import SwiftUI
import Combine


fileprivate class RefreshControl: ObservableObject {
	
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



struct ContentView: View {
    
    @ObservedObject fileprivate var refreshControl_1: RefreshControl = RefreshControl()
    @ObservedObject fileprivate var refreshControl_2: RefreshControl = RefreshControl()
    
    @ViewBuilder
    var body: some View {
        
        List {
            ScrollViewResolver(onResolve: { _ in
                // self.refreshControl.add(to: scrollView)
                // self.refreshControl.add(onValueChanged: onValueChanged)
            })
            ForEach(1...100, id: \.self) { eachRowIndex in
                Text("Row \(eachRowIndex)")
            }
                .opacity(self.refreshControl_1.isRefreshing ? 0.2 : 1.0)
        }
        
        List {
            RefreshControlInjector(
                refreshControl: self.refreshControl_2,
                onValueChanged: {
                self.refresh_2()
            })
            ForEach(1...100, id: \.self) { eachRowIndex in
                Text("Row \(eachRowIndex)")
            }
                .opacity(self.refreshControl_2.isRefreshing ? 0.2 : 1.0)
        }
    }
    
    func refresh_1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl_1.isRefreshing = false
        }
    }
    
    func refresh_2() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl_2.isRefreshing = false
        }
    }
}

struct RefreshControlInjector: View {
    
    fileprivate var refreshControl: RefreshControl
    let onValueChanged: () -> Void
    
    var body: some View {
        ScrollViewResolver(onResolve: { (scrollView: UIScrollView) in
            self.refreshControl.add(to: scrollView)
            self.refreshControl.add(onValueChanged: onValueChanged)
        })
    }
}
