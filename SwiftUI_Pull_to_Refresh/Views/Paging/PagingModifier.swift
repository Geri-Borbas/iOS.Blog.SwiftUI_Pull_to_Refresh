//
//  PagingModifier.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 20/09/2021.
//

import Foundation
import SwiftUI


private struct PagingModifier: ViewModifier {
	
	@State var geometryReaderFrame: CGRect = .zero
		
	func body(content: Content) -> some View {
		content
			.background(
				GeometryReader { geometry in
					ScrollViewMatcher(
						onResolve: { scrollView in
							scrollView.isPagingEnabled = true
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
	
	func paging() -> some View {
		self.modifier(PagingModifier())
	}
}
