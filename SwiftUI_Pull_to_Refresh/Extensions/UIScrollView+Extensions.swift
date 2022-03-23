//
//  UIScrollView+Extensions.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 23/03/2022.
//

import Foundation
import UIKit


extension UIScrollView {
	
	func set(decelerationRate: CGFloat) {
		self.decelerationRate = .init(rawValue: decelerationRate)
	}
	
	func set(pagingFriction: CGFloat) {
		self.setValue(pagingFriction, forKey: "pagingFriction")
	}
}
