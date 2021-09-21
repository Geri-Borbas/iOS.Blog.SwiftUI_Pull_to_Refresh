//
//  UIView+Extensions.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/09/2021.
//

import Foundation
import UIKit


extension UIView {
	
	/// Returs frame in screen coordinates.
	var globalFrame: CGRect {
		if let window = window {
			return convert(bounds, to: window.screen.coordinateSpace)
		} else {
			return .zero
		}
	}
	
	/// Returns with all the instances of the given view type in the view hierarchy.
	func viewsInHierarchy<ViewType: UIView>() -> [ViewType]? {
		var views: [ViewType] = []
		viewsInHierarchy(views: &views)
		return views.count > 0 ? views : nil
	}
	
	fileprivate func viewsInHierarchy<ViewType: UIView>(views: inout [ViewType]) {
		subviews.forEach { eachSubView in
			if let matchingView = eachSubView as? ViewType {
				views.append(matchingView)
			}
			eachSubView.viewsInHierarchy(views: &views)
		}
	}
	
	/// Search ancestral view hierarcy for the given view type.
	func searchViewAnchestorsFor<ViewType: UIView>(
		_ onViewFound: (ViewType) -> Void
	) {
		if let matchingView = self.superview as? ViewType {
			onViewFound(matchingView)
		} else {
			superview?.searchViewAnchestorsFor(onViewFound)
		}
	}
	
	/// Search ancestral view hierarcy for the given view type.
	func searchViewAnchestorsFor<ViewType: UIView>() -> ViewType? {
		if let matchingView = self.superview as? ViewType {
			return matchingView
		} else {
			return superview?.searchViewAnchestorsFor()
		}
	}
	
	func printViewHierarchyInformation(_ level: Int = 0) {
		printViewInformation(level)
		self.subviews.forEach { $0.printViewHierarchyInformation(level + 1) }
	}
		
	func printViewInformation(_ level: Int) {
		let leadingWhitespace = String(repeating: "    ", count: level)
		let className = "\(Self.self)"
		let superclassName = "\(self.superclass!)"
		let frame = "\(self.frame)"
		let id = (self.accessibilityIdentifier == nil) ? "" : " `\(self.accessibilityIdentifier!)`"
		print("\(leadingWhitespace)\(className): \(superclassName)\(id) \(frame)")
	}
}
