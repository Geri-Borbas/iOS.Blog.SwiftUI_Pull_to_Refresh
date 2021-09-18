//
//  RefreshControlModifier.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/09/2021.
//

import Foundation
import SwiftUI


struct FramePreferenceKey: PreferenceKey {
	
	typealias Value = CGRect
	static var defaultValue = CGRect.zero
	
	static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
		value = nextValue()
	}
}


struct RefreshControlModifier: ViewModifier {
	
	@State var globalFrame: CGRect = .zero
	let refreshControl: RefreshControl
	
	internal init(onValueChanged: @escaping (UIRefreshControl) -> Void) {
		self.refreshControl = RefreshControl(onValueChanged: onValueChanged)
	}
	
	func body(content: Content) -> some View {
		content
			.background(
				GeometryReader { geometry in
					ScrollViewMatcher(
						onResolve: { scrollView in
							refreshControl.add(to: scrollView)
						},
						geometryReaderFrame: $globalFrame
					)
					.background(Color.blue)
					.preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
					.onPreferenceChange(FramePreferenceKey.self) { frame in
						self.globalFrame = frame
					}
				}
			)
	}
}


extension View {
	
	func refreshControl(onValueChanged: @escaping (_ refreshControl: UIRefreshControl) -> Void) -> some View {
		self.modifier(RefreshControlModifier(onValueChanged: onValueChanged))
	}
}
