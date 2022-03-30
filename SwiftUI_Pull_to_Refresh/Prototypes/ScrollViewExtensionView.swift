//
//  ScrollViewExtensionView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 14/03/2022.
//

import SwiftUI
import Introspect
import Refreshable


struct ScrollViewExtensionView: View {
	
	@ObservedObject var viewModel = ViewModel()
	
	var body: some View {
		List {
			ForEach(1...100, id: \.self) { eachRowIndex in
				Text("Row \(eachRowIndex)")
			}
		}
		.introspectTableView { tableView in
			tableView.onRefresh { refreshControl in
				viewModel.fetch {
					refreshControl.endRefreshing()
				}
			}
		}
	}
}
