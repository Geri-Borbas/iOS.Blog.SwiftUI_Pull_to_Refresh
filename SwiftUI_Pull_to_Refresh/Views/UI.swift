//
//  UI.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/03/2022.
//

import SwiftUI


extension Text {
	
	func titleStyle() -> Self {
		self.font(Font.custom("Lato-Light", size: 40))
	}
	
	func subtitleStyle() -> Self {
		self
			.font(Font.custom("Lato-Regular", size: 14))
			.foregroundColor(.gray)
	}
}
