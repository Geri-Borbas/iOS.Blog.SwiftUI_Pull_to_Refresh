//
//  ClosureBasedModifierView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 14/03/2022.
//

import SwiftUI
import Introspect


struct ClosureBasedModifierView: View {
	
	var body: some View {
		List {
			ForEach(1...100, id: \.self) { eachRowIndex in
				Text("Row \(eachRowIndex)")
			}
		}
		.onRefresh { refreshControl in
			Network.load {
				refreshControl.endRefreshing()
			}
		}
	}
}
