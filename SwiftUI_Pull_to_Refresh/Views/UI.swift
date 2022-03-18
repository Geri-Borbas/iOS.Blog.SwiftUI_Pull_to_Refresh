//
//  UI.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/03/2022.
//

import SwiftUI


struct UI {
	
	static let padding = 5
}


extension Text {
	
	func titleStyle() -> Self {
		self.font(Font.custom("Lato-Light", size: 40))
	}
	
	func subtitleStyle() -> Self {
		self
			.font(Font.custom("Lato-Regular", size: 14))
			.foregroundColor(.gray)
	}
	
	func heroStyle(black: Bool = true) -> some View {
		self
			.font(Font.custom(black ? "Lato-Black" : "Lato-Regular", size: 68))
			.frame(maxHeight: 64)
	}
	
	func regularStyle() -> Self {
		self
			.font(Font.custom("Lato-Regular", size: 24))
	}
	
	func secondaryStyle() -> some View {
		self
			.font(Font.custom("Lato-Light", size: 20))
			.opacity(0.4)
	}
}


extension Image {
	
	
	func heroStyle() -> some View {
		self
			.font(.system(size: 72))
			.foregroundColor(Color("Green"))
	}
}
