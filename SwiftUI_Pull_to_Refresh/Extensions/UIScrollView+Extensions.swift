//
//  UIScrollView+Extensions.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 23/03/2022.
//

import Foundation
import UIKit


extension UIScrollView {
	
	func swizzle() {
		
		guard let scrollViewClass: AnyClass = object_getClass(self) else {
			return print("Could not get class.")
		}
		
		let selector = Selector("_getPagingDecelerationOffset:forTimeInterval:")
		guard let method = class_getInstanceMethod(scrollViewClass, selector) else {
			return print("Could not get selector.")
		}
		
		guard let originalMethod = class_getInstanceMethod(scrollViewClass, #selector(originalGetPagingDecelerationOffset(_:forTimeInterval:))) else {
			return print("Could not get original selector.")
		}
		
		guard let swizzledMethod = class_getInstanceMethod(scrollViewClass, #selector(swizzleGetPagingDecelerationOffset(_:forTimeInterval:))) else {
			return print("Could not get swizzled selector.")
		}
		
		// Swap.
		method_exchangeImplementations(method, originalMethod)
		method_exchangeImplementations(method, swizzledMethod)
	}
	
//	- (BOOL)_getPagingDecelerationOffset:(struct CADoublePoint { double x1; double x2; }*)arg1 forTimeInterval:(double)arg2;
	
	@objc func originalGetPagingDecelerationOffset(_ arg1: UnsafeMutablePointer<CGPoint>, forTimeInterval arg2: TimeInterval) -> Bool {
		return true
	}
	
	@objc func swizzleGetPagingDecelerationOffset(_ arg1: UnsafeMutablePointer<CGPoint>, forTimeInterval arg2: TimeInterval) -> Bool {
		
		print("arg1: \(arg1.pointee)")
		print("arg2: \(arg2)")
		
		return originalGetPagingDecelerationOffset(arg1, forTimeInterval: arg2)
	}
	
		// Bouncing.
//		- (BOOL)_getBouncingDecelerationOffset:(double*)arg1
//		forTimeInterval:(double)arg2
//		lastUpdateOffset:(double)arg3
//		min:(double)arg4
//		max:(double)arg5
//		decelerationFactor:(double)arg6
//		decelerationLnFactor:(double)arg7
//		velocity:(double*)arg8;

//		- (void)_getStandardDecelerationOffset:(double*)arg1
//		forTimeInterval:(double)arg2
//		min:(double)arg3
//		max:(double)arg4
//		decelerationFactor:(double)arg5
//		decelerationLnFactor:(double)arg6
//		velocity:(double*)arg7;


	func set(speed: CGFloat) {
		
		swizzle()
		
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
	}
	
	fileprivate func set(decelerationRate: CGFloat) {
		self.decelerationRate = .init(rawValue: decelerationRate)
	}
	
	fileprivate func set(pagingFriction: CGFloat) {
		self.setValue(pagingFriction, forKey: "pagingFriction")
	}
}
