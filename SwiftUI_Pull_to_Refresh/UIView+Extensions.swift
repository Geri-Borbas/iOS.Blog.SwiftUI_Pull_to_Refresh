//
//  SearchBar.swift
//  SwiftUI_Search_Bar_in_Navigation_Bar
//
//  Created by Geri Borbás on 2020. 04. 27..
//  Copyright © 2020. Geri Borbás. All rights reserved.
//

import SwiftUI


extension UIView {
    
    /// Print view hierarchy information.
    func printViewHierarchy() {
        print("")
        print("printViewHierarchy()")
        self.printSubviews()
    }
    
    func printSubviews(_ level: Int = 0) {
        printViewInformation(level)
        self.subviews.forEach { $0.printSubviews(level + 1) }
    }
    
    func printViewInformation(_ level: Int) {
        let leadingWhitespace = String(repeating: "  ", count: level)
        let className = "\(Self.self)"
        let superclassName = "\(self.superclass!)"
        let id = self.accessibilityIdentifier ?? ""
        print("\(leadingWhitespace)\(superclassName) (\(className) `\(id)`")
        // print("\(leadingWhitespace)\(self.accessibilityIdentifier)")
        // print("\(leadingWhitespace)\(className) `\(self.accessibilityIdentifier)`")
    }
}
