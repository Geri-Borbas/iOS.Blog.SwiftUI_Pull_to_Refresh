//
//  XCTestCase+Extensions.swift
//  SwiftUI_Pull_to_RefreshUITests
//
//  Created by Geri Borbás on 2020. 07. 27..
//

import XCTest

extension XCTestCase {

    static var disabledQuiescenceWaiting = false

    /// Swizzle `XCUIApplicationProcess.waitForQuiescenceIncludingAnimationsIdle(:)`
    /// to empty method. Invoke at `setUp()`/`setUpWithError()` of your test case.
    func disableQuiescenceWaiting() {
        
        // Only if not disabled yet.
        guard Self.disabledQuiescenceWaiting == false else { return }
        
        // Swizzle.
        if
            let `class`: AnyClass = objc_getClass("XCUIApplicationProcess") as? AnyClass,
            let quiescenceWaitingMethod = class_getInstanceMethod(`class`, Selector(("waitForQuiescenceIncludingAnimationsIdle:"))),
            let emptyMethod = class_getInstanceMethod(type(of: self), #selector(Self.empty))
        {
            method_exchangeImplementations(quiescenceWaitingMethod, emptyMethod)
            Self.disabledQuiescenceWaiting = true
        }
    }

    @objc func empty() {
        return
    }
}
