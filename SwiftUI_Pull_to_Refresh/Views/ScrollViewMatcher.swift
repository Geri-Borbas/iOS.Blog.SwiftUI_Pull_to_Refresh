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
	@Binding var globalFrame: CGRect
		
	init(onResolve: @escaping (UIScrollView) -> Void, geometryReaderFrame: Binding<CGRect>) {
		self.onMatch = onResolve
		self._globalFrame = geometryReaderFrame
	}
	
	func makeUIViewController(context: Context) -> ScrollViewMatcherViewController {
		ScrollViewMatcherViewController(onResolve: onMatch, geometryReaderFrame: $globalFrame)
	}
	
	func updateUIViewController(_ uiViewController: ScrollViewMatcherViewController, context: Context) { }
}

class ScrollViewMatcherViewController: UIViewController {
	
	let onMatch: (UIScrollView) -> Void
	@Binding var geometryReaderFrame: CGRect
	
	init(onResolve: @escaping (UIScrollView) -> Void, geometryReaderFrame: Binding<CGRect>) {
		self.onMatch = onResolve
		self._geometryReaderFrame = geometryReaderFrame
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Use init(onMatch:) to instantiate ScrollViewMatcherViewController.")
	}
		
	override func didMove(toParent parent: UIViewController?) {
		super.didMove(toParent: parent)
		
		if let parent = parent {
			
			if let scrollViewsInHierarchy: [UIScrollView] = parent.viewsInHierarchy() {
				
				print("---")
				print("scrollViewsInHierarchy.count \(scrollViewsInHierarchy.count).")
				
				// Return first match if only a single scroll view is found in the hierarchy.
				if scrollViewsInHierarchy.count == 1,
				   let firstScrollViewInHierarchy = scrollViewsInHierarchy.first {
					onMatch(firstScrollViewInHierarchy)

				// Filter by frames if multiple matches found.
				} else {
					if let firstMatchingFrame = scrollViewsInHierarchy.filter({ eachScrollView in
						
						let globalFrame = eachScrollView.globalFrame
						let areOriginsClose = globalFrame.origin.close(to: geometryReaderFrame.origin)
						
						// Log.
						print("---")
						print("geometryReaderFrame: \(geometryReaderFrame)")
						print("globalFrame: \(globalFrame)")
						print("areOriginsClose: \(areOriginsClose)")
						
						return areOriginsClose
					}).first {
						onMatch(firstMatchingFrame)
					}
				}
			}
		}
	}
}


fileprivate extension CGPoint {
	
	/// Returns `true` if this point is close the other point (considering a ~1 point tolerance).
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
