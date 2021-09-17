//
//  ContentView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI


struct FramePreferenceKey: PreferenceKey {
	typealias Value = CGRect
	static var defaultValue = CGRect.zero

	static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
		value = nextValue()
	}
}


struct ContentView: View {
	
	let refreshControl: RefreshControl = RefreshControl()
	@State var frame: CGRect = .zero
	
	var body: some View {
		List {
			ForEach(1...100, id: \.self) { eachRowIndex in
				Text("Row \(eachRowIndex)")
			}
		}
		.background(
			GeometryReader { geometry in
				ScrollViewMatcher(onResolve: { scrollView in
					print(scrollView)
				}, frame: $frame)
				.preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
				.onPreferenceChange(FramePreferenceKey.self) { frame in
					self.frame = frame
				}
			}
			
		)
		.onAppear {
			self.refreshControl.onValueChanged = {
				DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
					self.refreshControl.refreshControl?.endRefreshing()
				}
			}
		}
	}
}
