//
//  ScrollViewMatcher.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 17/09/2021.
//

import Foundation
import SwiftUI


final class ScrollViewMatcher: UIViewControllerRepresentable {
	
	let onResolve: (UIScrollView) -> Void
	@Binding var frame: CGRect
		
	init(onResolve: @escaping (UIScrollView) -> Void, frame: Binding<CGRect>) {
		self.onResolve = onResolve
		self._frame = frame
	}
	
	func makeUIViewController(context: Context) -> ScrollViewMatcherViewController {
		ScrollViewMatcherViewController(onResolve: onResolve, frame: $frame)
	}
	
	func updateUIViewController(_ uiViewController: ScrollViewMatcherViewController, context: Context) {
		// context
	}
}

class ScrollViewMatcherViewController: UIViewController {
	
	let onResolve: (UIScrollView) -> Void
	@Binding var frame: CGRect
	
	init(onResolve: @escaping (UIScrollView) -> Void, frame: Binding<CGRect>) {
		self.onResolve = onResolve
		self._frame = frame
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Use init(onResolve:) to instantiate ParentResolverViewController.")
	}
		
	override func didMove(toParent parent: UIViewController?) {
		super.didMove(toParent: parent)
		
		if let parent = parent {
			
			print("view.frame: \(view.frame)")
			
			if let scrollViewsInHierarchy: [UIScrollView] = parent.viewsInHierarchy() {
				
				// Return first match if only one scroll view is present.
				if scrollViewsInHierarchy.count == 1,
				   let firstScrollViewInHierarchy = scrollViewsInHierarchy.first {
					print("Only one.")
					onResolve(firstScrollViewInHierarchy)
					
				// Filter by frames if multiple matches found.
				} else {
					if let firstScrollViewWithMatchingFrame = scrollViewsInHierarchy.filter({ eachScrollViewInHierarchy in
						print("frame: \(frame)")
						print("eachScrollViewInHierarchy.frameInWindowCoordinateSpace: \(eachScrollViewInHierarchy.frameInWindowCoordinateSpace)")
						return eachScrollViewInHierarchy.frameInWindowCoordinateSpace == frame
					}).first {
						onResolve(firstScrollViewWithMatchingFrame)
					}
				}
			}
		}
	}
}


fileprivate extension UIViewController {
	
	func viewsInHierarchy<ViewType: UIView>() -> [ViewType]? {
		view.viewsInHierarchy()
	}
}


fileprivate extension UIView {
	
	var frameInWindowCoordinateSpace: CGRect {
		if let window = window {
			return convert(frame, to: window.screen.fixedCoordinateSpace)
		} else {
			return .zero
		}
	}
	
	func viewsInHierarchy<ViewType: UIView>() -> [ViewType]? {
		var views: [ViewType] = []
		viewsInHierarchy(views: &views)
		print("views: \(views)")
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
