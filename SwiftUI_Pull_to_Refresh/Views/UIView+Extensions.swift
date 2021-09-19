//
//  UIView+Extensions.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/09/2021.
//

import Foundation
import UIKit


extension UIView {
	
	/// Search ancestral view hierarchy for the given view type.
	func searchViewAnchestors<ViewType: UIView>(for viewType: ViewType.Type) -> ViewType? {
		if let matchingView = self.superview as? ViewType {
			return matchingView
		} else {
			return superview?.searchViewAnchestors(for: viewType)
		}
	}
	
	/// Convinience.
	func testable(as id: String) -> Self {
		self.isAccessibilityElement = true
		self.accessibilityIdentifier = id
		return self
	}
}
