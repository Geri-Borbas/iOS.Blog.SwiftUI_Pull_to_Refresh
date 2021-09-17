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
		
		if parent != nil {
			
			print("frame: \(frame)")
			print("view.frame: \(view.frame)")
			
			if let scrollViewMatch = scrollViewsInHierarchy.first {
				onResolve(scrollViewMatch)
			}
		}
	}
}

fileprivate extension UIViewController {
	
	var scrollViewsInHierarchy: [UIScrollView] {
		[]
	}
}
