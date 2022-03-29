//
//  UIScrollView+Extensions.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 23/03/2022.
//

import Foundation
import UIKit


extension UIScrollView {
	
	static var speed = UI.Speed()

	func set(speed: UI.Speed) {
		
		// Only if tweaked.
		guard speed.layerSpeed != 1.0 else {
			return
		}
		
		// Save.
		Self.speed = speed
		
		print("original decelerationRate: \(self.decelerationRate.rawValue)")
		
		// Scroll deceleration.
		self.decelerationRate = .init(rawValue: speed.decelerationRate)
		self.setValue(speed.pagingFriction, forKey: "pagingFriction")
		self.setValue(speed.decelerationRate, forKey: "verticalScrollDecelerationFactor")
		self.setValue(speed.decelerationRate, forKey: "horizontalScrollDecelerationFactor")
		
		// Bounce.
		swizzleGetBouncingDecelerationOffset()
	}
	
	func swizzleGetBouncingDecelerationOffset() {
		
		guard let scrollViewClass: AnyClass = object_getClass(self) else {
			return print("Could not get `UIScrollView` class.")
		}
		
		let selectorName = "_getBouncingDecelerationOffset:forTimeInterval:lastUpdateOffset:min:max:decelerationFactor:decelerationLnFactor:velocity:"
		let selector = Selector(selectorName)
		guard let method = class_getInstanceMethod(scrollViewClass, selector) else {
			return print("Could not get `getBouncingDecelerationOffset()` selector.")
		}
		
		let originalSelector = #selector(originalGetBouncingDecelerationOffset(_:forTimeInterval:lastUpdateOffset:min:max:decelerationFactor:decelerationLnFactor:velocity:))
		guard let originalMethod = class_getInstanceMethod(scrollViewClass, originalSelector) else {
			return print("Could not get original `getBouncingDecelerationOffset()` selector.")
		}
		
		let swizzledSelector = #selector(swizzledGetBouncingDecelerationOffset(_:forTimeInterval:lastUpdateOffset:min:max:decelerationFactor:decelerationLnFactor:velocity:))
		guard let swizzledMethod = class_getInstanceMethod(scrollViewClass, swizzledSelector) else {
			return print("Could not get swizzled `getBouncingDecelerationOffset()` selector.")
		}
		
		// Swap implementations.
		method_exchangeImplementations(method, originalMethod)
		method_exchangeImplementations(method, swizzledMethod)
	}
	
//	- (BOOL)_getBouncingDecelerationOffset:(double*)arg1
//	forTimeInterval:(double)arg2
//	lastUpdateOffset:(double)arg3
//	min:(double)arg4
//	max:(double)arg5
//	decelerationFactor:(double)arg6
//	decelerationLnFactor:(double)arg7
//	velocity:(double*)arg8;
	
	@objc func originalGetBouncingDecelerationOffset(
		_ bouncingDecelerationOffset: UnsafeMutablePointer<CGFloat>,
		forTimeInterval timeInterval: TimeInterval,
		lastUpdateOffset: TimeInterval,
		min: CGFloat,
		max: CGFloat,
		decelerationFactor: CGFloat,
		decelerationLnFactor: CGFloat,
		velocity: UnsafeMutablePointer<CGFloat>
	) -> Bool {
		return true // Original implementation will be copied here
	}
	
	@objc func swizzledGetBouncingDecelerationOffset(
		_ bouncingDecelerationOffset: UnsafeMutablePointer<CGFloat>,
		forTimeInterval timeInterval: TimeInterval,
		lastUpdateOffset: TimeInterval,
		min: CGFloat,
		max: CGFloat,
		decelerationFactor: CGFloat,
		decelerationLnFactor: CGFloat,
		velocity: UnsafeMutablePointer<CGFloat>
	) -> Bool {
		return originalGetBouncingDecelerationOffset(
			bouncingDecelerationOffset,
			forTimeInterval: timeInterval * CGFloat(Self.speed.layerSpeed), // ✨
			lastUpdateOffset: lastUpdateOffset,
			min: min,
			max: max,
			decelerationFactor: decelerationFactor,
			decelerationLnFactor: decelerationLnFactor,
			velocity: velocity
		)
	}
}
