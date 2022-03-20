//
//  UI.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/03/2022.
//

import SwiftUI


struct UI {
	
	static let padding = 5
	static let background = "Background"
	
	struct Spacing {
		
		static let screen = CGFloat(16)
	}
	
	static let cornerRadius = CGFloat(32)
	
	struct Image {
		
		static let worldMap = SwiftUI.Image("WorldMap")
	}
	
	struct Color {
		
		static let green = SwiftUI.Color("Green")
		static let background = SwiftUI.Color("Background")
	}
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
			.foregroundColor(.white)
			.frame(maxHeight: 64)
	}
	
	func regularStyle() -> Self {
		self
			.font(Font.custom("Lato-Regular", size: 24))
			.foregroundColor(.white)
	}
	
	func attributeStyle() -> Self {
		self
			.font(Font.custom("Lato-Regular", size: 14))
			.foregroundColor(Color("Green"))
	}
	
	func valueStyle() -> some View {
		self
			.font(Font.custom("Lato-Regular", size: 14))
			.frame(maxHeight: 14)
	}
	
	func unitStyle() -> some View {
		self
			.font(Font.custom("Lato-Thin", size: 10))
			.frame(maxHeight: 12)
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
	
	func iconStyle() -> some View {
		self
			.font(.system(size: 24))
			.foregroundColor(Color("Green"))
	}
}


extension View {
	
	func featuredBackgroundStyle() -> some View {
		self
			.background(
				Color("Gray")
					.overlay(
						LinearGradient(
							gradient: Gradient(
								colors: [
									.clear,
									Color("Green").opacity(0.2)
								]
							),
							startPoint: UnitPoint(x: 0, y: 0.7),
							endPoint: UnitPoint(x: 0, y: 1.0)
						)
					)
			)
			.cornerRadius(UI.cornerRadius)
	}
	
	func listBackgroundStyle() -> some View {
		self
			.background(
				LinearGradient(
					gradient: Gradient(
						colors: [
							Color("Dark Gray"),
							Color("Medium Gray")
						]
					),
					startPoint: .top,
					endPoint: .bottom
				)
					.opacity(0.5)
			)
	}
}
