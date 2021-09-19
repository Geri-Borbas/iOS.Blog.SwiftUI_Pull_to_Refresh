//
//  Bundle+Extensions.swift
//  Sudoku
//
//  Created by Geri Borbás on 29/03/2021.
//

import Foundation


extension Bundle {
	
	static var current: Bundle {
		class `Class` { }
		return Bundle(for: `Class`.self)
	}
}
