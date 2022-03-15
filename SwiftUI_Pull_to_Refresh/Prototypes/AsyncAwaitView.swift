//
//  AsyncAwaitView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 15/03/2022.
//

import SwiftUI
import Introspect


struct AsyncAwaitView: View {
	
	var body: some View {
		List {
			ForEach(1...100, id: \.self) { eachRowIndex in
				Text("Row \(eachRowIndex)")
			}
		}
		.refreshable {
			await Network.load()
		}
	}
}


struct RefreshableModifier: ViewModifier {
	
	let action: () async -> Void
	
	func body(content: Content) -> some View {
		content
			.onRefresh { refreshControl in
				Task {
					await action()
					refreshControl.endRefreshing()
				}
			}
	}
}


extension View {

	func refreshable(action: @escaping () async -> Void) -> some View {
		self.modifier(RefreshableModifier(action: action))
	}
}
