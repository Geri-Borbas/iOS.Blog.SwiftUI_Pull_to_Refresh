//
//  RefreshControlClosureView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 14/03/2022.
//

import SwiftUI
import Introspect


fileprivate class RefreshControlTarget: ObservableObject {
	
	private var onValueChanged: ((_ refreshControl: UIRefreshControl) -> Void)?
	
	func use(for scrollView: UIScrollView, onValueChanged: @escaping ((UIRefreshControl) -> Void)) {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(
			   self,
			   action: #selector(self.onValueChangedAction),
			   for: .valueChanged
		   )
		scrollView.refreshControl = refreshControl
		self.onValueChanged = onValueChanged
	}
	
	@objc private func onValueChangedAction(sender: UIRefreshControl) {
		self.onValueChanged?(sender)
	}
}


struct RefreshControlClosureView: View {
		
	@ObservedObject fileprivate var target = RefreshControlTarget()
	
	var body: some View {
		List {
			ForEach(1...100, id: \.self) { eachRowIndex in
				Text("Row \(eachRowIndex)")
			}
		}
		.introspectTableView { tableView in
			target.use(for: tableView) { refreshControl in
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					refreshControl.endRefreshing()
				}
			}
		}
	}
}
