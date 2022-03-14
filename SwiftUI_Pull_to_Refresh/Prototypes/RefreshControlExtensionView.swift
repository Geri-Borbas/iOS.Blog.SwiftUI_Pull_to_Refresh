//
//  RefreshControlExtensionView.swift
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


fileprivate extension UIScrollView {
	
	struct Keys {
		static var target: UInt8 = 0
	}
	
	var target: RefreshControlTarget? {
		get {
			objc_getAssociatedObject(self, &Keys.target) as? RefreshControlTarget
		}
		set {
			objc_setAssociatedObject(self, &Keys.target, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
}


struct RefreshControlExtensionView: View {
	
	var body: some View {
		List {
			ForEach(1...100, id: \.self) { eachRowIndex in
				Text("Row \(eachRowIndex)")
			}
		}
		.introspectTableView { tableView in
			tableView.target = RefreshControlTarget()
			tableView.target?.use(for: tableView) { refreshControl in
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					refreshControl.endRefreshing()
				}
			}
		}
	}
}
