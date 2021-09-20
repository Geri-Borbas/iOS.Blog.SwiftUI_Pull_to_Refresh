//
//  ScrollViewMatcher.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 17/09/2021.
//

import Foundation
import SwiftUI
import Combine


final class ScrollViewMatcher: UIViewControllerRepresentable {
	
	let onMatch: (UIScrollView) -> Void
	@Binding var geometryReaderFrame: CGRect
	private var subscribers: Set<AnyCancellable> = []
	
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
				print("ScrollViewMatcherViewController.scrollView.didSet.onMatch")
				onMatch(scrollView)
			}
		}
	}
	
	var geometryReaderFrame: CGRect {
		didSet {
			match()
		}
	}
	
	init(onResolve: @escaping (UIScrollView) -> Void, geometryReaderFrame: CGRect) {
		self.onMatch = onResolve
		self.geometryReaderFrame = geometryReaderFrame
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Use init(onMatch:) to instantiate ScrollViewMatcherViewController.")
	}
	
	func match() {
		if let parent = parent {
			if let scrollViewsInHierarchy: [UIScrollView] = parent.viewsInHierarchy() {
				
				// Return first match if only a single scroll view is found in the hierarchy.
				if scrollViewsInHierarchy.count == 1,
				   let firstScrollViewInHierarchy = scrollViewsInHierarchy.first {
					self.scrollView = firstScrollViewInHierarchy
					
				// Filter by frame origins if multiple matches found.
				} else {
					if let firstMatchingFrameOrigin = scrollViewsInHierarchy.filter({
						let globalFrame = $0.globalFrame
//						print("globalFrame: \(globalFrame)")
//						print("geometryReaderFrame: \(geometryReaderFrame)")
						return globalFrame.origin.close(to: geometryReaderFrame.origin)
					}).first {
						self.scrollView = firstMatchingFrameOrigin
					}
				}
			}
		}
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


fileprivate extension UIViewController {
	
	func viewsInHierarchy<ViewType: UIView>() -> [ViewType]? {
		view.viewsInHierarchy()
	}
}


fileprivate extension UIView {
	
	var globalFrame: CGRect {
		if let window = window {
			return convert(frame, to: window.screen.coordinateSpace)
		} else {
			return .zero
		}
	}
	
	func viewsInHierarchy<ViewType: UIView>() -> [ViewType]? {
		var views: [ViewType] = []
		viewsInHierarchy(views: &views)
		return views.count > 0 ? views : nil
	}
	
	func viewsInHierarchy<ViewType: UIView>(views: inout [ViewType]) {
		subviews.forEach { eachSubView in
			if let matchingView = eachSubView as? ViewType {
				views.append(matchingView)
			}
			eachSubView.viewsInHierarchy(views: &views)
		}
	}
}
