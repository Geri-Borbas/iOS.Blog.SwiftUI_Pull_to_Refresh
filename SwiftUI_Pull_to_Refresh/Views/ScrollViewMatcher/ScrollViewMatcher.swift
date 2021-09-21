//
//  ScrollViewMatcher.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 17/09/2021.
//

import Foundation
import SwiftUI


final class ScrollViewMatcher: UIViewControllerRepresentable {
	
	let onMatch: (UIScrollView) -> Void
	@Binding var geometryReaderFrame: CGRect
	
	init(onResolve: @escaping (UIScrollView) -> Void, geometryReaderFrame: Binding<CGRect>) {
		self.onMatch = onResolve
		self._geometryReaderFrame = geometryReaderFrame
	}
	
	func makeUIViewController(context: Context) -> ScrollViewMatcherViewController {
		ScrollViewMatcherViewController(onResolve: onMatch, geometryReaderFrame: geometryReaderFrame)
	}
	
	func updateUIViewController(_ viewController: ScrollViewMatcherViewController, context: Context) {
		viewController.geometryReaderFrame = geometryReaderFrame
	}
}

class ScrollViewMatcherViewController: UIViewController {
	
	let onMatch: (UIScrollView) -> Void
	private var scrollView: UIScrollView? {
		didSet {
			if oldValue != scrollView,
			   let scrollView = scrollView {
				onMatch(scrollView)
			}
		}
	}
	
	var geometryReaderFrame: CGRect {
		didSet {
			match()
		}
	}
	
	init(onResolve: @escaping (UIScrollView) -> Void, geometryReaderFrame: CGRect, debug: Bool = false) {
		self.onMatch = onResolve
		self.geometryReaderFrame = geometryReaderFrame
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Use init(onMatch:) to instantiate ScrollViewMatcherViewController.")
	}
	
	func match() {
		// matchUsingHierarchy()
		matchUsingGeometry()
	}
	
	func matchUsingHierarchy() {
		if parent != nil {
			
			// Lookup view ancestry for any `UIScrollView`.
			view.searchViewAnchestorsFor { (scrollView: UIScrollView) in
				self.scrollView = scrollView
			}
		}
	}
	
	func matchUsingGeometry() {
		if let parent = parent {
			if let scrollViewsInHierarchy: [UIScrollView] = parent.view.viewsInHierarchy() {
				
				// Return first match if only a single scroll view is found in the hierarchy.
				if scrollViewsInHierarchy.count == 1,
				   let firstScrollViewInHierarchy = scrollViewsInHierarchy.first {
					self.scrollView = firstScrollViewInHierarchy
					
				// Filter by frame origins if multiple matches found.
				} else {
					if let firstMatchingFrameOrigin = scrollViewsInHierarchy.filter({
						$0.globalFrame.origin.close(to: geometryReaderFrame.origin)
					}).first {
						self.scrollView = firstMatchingFrameOrigin
					}
				}
			}
		}
	}
	
	override func didMove(toParent parent: UIViewController?) {
		super.didMove(toParent: parent)
		match()
	}
}

fileprivate extension CGPoint {
	
	/// Returns `true` if this point is close the other point (considering a ~1 pt tolerance).
	func close(to point: CGPoint) -> Bool {
		let inset = CGFloat(1)
		let rect = CGRect(x: x - inset, y: y - inset, width: inset * 2, height: inset * 2)
		return rect.contains(point)
	}
}
