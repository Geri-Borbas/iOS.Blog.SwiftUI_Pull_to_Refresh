//
//  RefreshControlModifier.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/09/2021.
//

import Foundation
import SwiftUI
import Combine


struct FramePreferenceKey: PreferenceKey {
	
	typealias Value = CGRect
	static var defaultValue = CGRect.zero
	
	static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
		value = nextValue()
	}
}


struct RefreshControlModifier: ViewModifier {
	
	@State var geometryReaderFrame: CGRect = .zero
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
						geometryReaderFrame: $geometryReaderFrame
					)
					.preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
					.onPreferenceChange(FramePreferenceKey.self) { frame in
						self.geometryReaderFrame = frame
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
