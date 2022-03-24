//
//  UIScrollView+Extensions.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 23/03/2022.
//

import Foundation
import UIKit


extension UIScrollView {
	
	func set(speed: CGFloat) {
		
		// Only on change.
		guard speed != 1 else {
			return
		}
		
		// Scroll deceleration.
		let decelerationRate = self.decelerationRate.rawValue
		print("decelerationRate: \(decelerationRate)")
		let decelerationRateExponent = pow(decelerationRate, speed)
		set(decelerationRate: decelerationRateExponent)
		
		// Paging.
		let pagingFriction: CGFloat = value(forKey: "pagingFriction") as? CGFloat ?? 0
		print("pagingFriction: \(pagingFriction)")
		let pagingFrictionExponent = pow(pagingFriction, 1 / speed)
		set(pagingFriction: pagingFrictionExponent)
		
		// Bouncing.
//		- (BOOL)_getBouncingDecelerationOffset:(double*)arg1
//		forTimeInterval:(double)arg2
//		lastUpdateOffset:(double)arg3
//		min:(double)arg4
//		max:(double)arg5
//		decelerationFactor:(double)arg6
//		decelerationLnFactor:(double)arg7
//		velocity:(double*)arg8;
//			
//		- (BOOL)_getPagingDecelerationOffset:(struct CADoublePoint { double x1; double x2; }*)arg1 forTimeInterval:(double)arg2;
//
//		- (void)_getStandardDecelerationOffset:(double*)arg1
//		forTimeInterval:(double)arg2
//		min:(double)arg3
//		max:(double)arg4
//		decelerationFactor:(double)arg5
//		decelerationLnFactor:(double)arg6
//		velocity:(double*)arg7;
	}
	
	fileprivate func set(decelerationRate: CGFloat) {
		self.decelerationRate = .init(rawValue: decelerationRate)
	}
	
	fileprivate func set(pagingFriction: CGFloat) {
		self.setValue(pagingFriction, forKey: "pagingFriction")
	}
}
