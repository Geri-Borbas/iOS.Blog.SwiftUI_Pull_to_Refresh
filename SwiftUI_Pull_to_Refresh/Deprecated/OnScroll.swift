//
//  OnScroll.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 21/09/2021.
//

import Foundation
import SwiftUI


class ScrollViewDelegate: NSObject, UIScrollViewDelegate {
	
	let onScroll: ((_ scrollView: UIScrollView) -> Void)
	
	init(onScroll: @escaping ((_ scrollView: UIScrollView) -> Void)) {
		self.onScroll = onScroll
	}
	
	@objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
		onScroll(scrollView)
	}
}

private struct OnScrollModifier: ViewModifier {
	
	@State var geometryReaderFrame: CGRect = .zero
	let scrollViewDelegate: ScrollViewDelegate
	
	init(onScroll: @escaping ((_ scrollView: UIScrollView) -> Void)) {
		self.scrollViewDelegate = ScrollViewDelegate(onScroll: onScroll)
	}
	
	func body(content: Content) -> some View {
		content
			.background(
				GeometryReader { geometry in
					ScrollViewMatcher(
						onResolve: { scrollView in
							scrollView.delegate = scrollViewDelegate
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
	
	func onScroll(onScroll: @escaping ((_ scrollView: UIScrollView) -> Void)) -> some View {
		self.modifier(OnScrollModifier(onScroll: onScroll))
	}
}
