//
//  SwiftUI_Pull_to_RefreshUITests.swift
//  SwiftUI_Pull_to_RefreshUITests
//
//  Created by Geri Borbás on 2020. 07. 25..
//

import XCTest
import CoreGraphics

class SwiftUI_Pull_to_RefreshUITests: XCTestCase {

    override func setUpWithError() throws {
        disableQuiescenceWaiting()
    }

    func testRefreshControlAfterScrollOffScreen() throws {
        
        // App.
        let app = XCUIApplication()
        app.launch()
        
        // Wait 2 seconds.
        app.press(forDuration: 2)
        
        // Pull to refresh.
        app.row("Row 1").drag(to: CGVector(dx: 0, dy: 10))
        
        // Refresh control should be appeared.
        XCTAssertTrue(
            app.refreshControl.waitForExistence(timeout: 2),
            "Refresh control should be appeared."
        )
        
        // Scroll off-screen.
        let dragAmount = 20
        app.row("Row 1").drag(to: CGVector(dx: 0, dy: -dragAmount))
        app.row("Row 10").drag(to: CGVector(dx: 0, dy: dragAmount))
        
        // Pull to refresh.
        app.row("Row 1").drag(to: CGVector(dx: 0, dy: 10))
        
        // Refresh control should be disappeared (within 1 seconds).
        XCTAssertTrue(
            app.refreshControl.waitForNonExistence(timeout: 2),
            "Refresh control should be disappeared (within 1 seconds)."
        )
    }
}

extension XCUIApplication {
    
    func row(_ name: String) -> XCUIElement {
        self.tables.cells[name].children(matching: .other).element(boundBy: 0)
    }
    
    var refreshControl: XCUIElement {
        self.otherElements["RefreshControl"]
    }
}

extension XCUIElement {
    
    func drag(to vector: CGVector) {
        self.coordinate(withNormalizedOffset: CGVector())
            .press(
                forDuration: 0,
                thenDragTo: self.coordinate(withNormalizedOffset: vector)
            )
    }
    
    func waitForNonExistence(timeout: TimeInterval) -> Bool {
        return XCTWaiter()
            .wait(
                for: [
                    XCTNSPredicateExpectation(
                        predicate: NSPredicate(format: "exists == false"),
                        object: self)
                ],
                timeout: timeout
            ) == .completed
    }
}
