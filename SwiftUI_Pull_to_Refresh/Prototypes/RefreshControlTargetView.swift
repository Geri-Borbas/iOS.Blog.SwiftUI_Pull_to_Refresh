//
//  RefreshControlTargetView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 14/03/2022.
//

import SwiftUI
import Introspect


fileprivate class RefreshControlTarget: ObservableObject {
	
	@objc func onValueChangedAction(sender: UIRefreshControl) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			sender.endRefreshing()
		}
	}
}


struct RefreshControlTargetView: View {
		
	@ObservedObject fileprivate var target = RefreshControlTarget()
	
	var body: some View {
		List {
			ForEach(1...100, id: \.self) { eachRowIndex in
				Text("Row \(eachRowIndex)")
			}
		}
		.introspectTableView { tableView in
			tableView.refreshControl = UIRefreshControl()
			tableView.refreshControl?.addTarget(
				target,
				action: #selector(RefreshControlTarget.onValueChangedAction),
				for: .valueChanged
			)
		}
	}
}
