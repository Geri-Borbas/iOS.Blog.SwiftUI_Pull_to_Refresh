//
//  StaticRefreshControlView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 14/03/2022.
//

import SwiftUI
import Introspect


struct StaticRefreshControlView: View {
		
	var body: some View {
		List {
			ForEach(1...100, id: \.self) { eachRowIndex in
				Text("Row \(eachRowIndex)")
			}
		}
		.introspectTableView { tableView in
			tableView.refreshControl = UIRefreshControl()
		}
	}
}
