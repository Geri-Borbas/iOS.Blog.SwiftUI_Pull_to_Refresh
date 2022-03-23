//
//  UI.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/03/2022.
//

import SwiftUI


struct UI {
			
	static let padding = CGFloat(16)
	static var topPadding: CGFloat {
		if #available(iOS 15.0, *) {
			return 8
		} else {
			return 0
		}
	}
	
	static let cornerRadius = CGFloat(32)
	static let rowHeight = CGFloat(40)
	static let lineWidth = CGFloat(4)
	static let speed = Float(0.5) // 1.0
	
	struct Image {
		
		static let blur = CGFloat(4)
		static let background = SwiftUI.Image("WorldMap")
		static let opaqueBackground = SwiftUI.Image("Opaque World Map")
		static let opaqueBackgroundWithBlur = SwiftUI.Image("Opaque World Map with Blur")
	}
	
	struct Color {
		
		static let foreground = SwiftUI.Color("Foreground")
		static let gray = SwiftUI.Color("Gray")
		static let mediumGray = SwiftUI.Color("Medium Gray")
		static let darkGray = SwiftUI.Color("Dark Gray")
		static let background = SwiftUI.Color("Background")
		static let green = SwiftUI.Color("Green")
	}
}


extension Text {
	
	func heroStyle(black: Bool = true) -> some View {
		self
			.font(Font.custom(black ? "Lato-Black" : "Lato-Regular", size: 60))
			.foregroundColor(UI.Color.foreground)
	}
	
	func titleStyle() -> some View {
		self
			.font(Font.custom("Lato-Light", size: 36))
			.foregroundColor(UI.Color.foreground)
	}
	
	func subtitleStyle() -> Self {
		self
			.font(Font.custom("Lato-Regular", size: 24))
			.foregroundColor(UI.Color.foreground)
	}
	
	func largeStyle() -> some View {
		self
			.font(Font.custom("Lato-Regular", size: 20))
			.foregroundColor(UI.Color.foreground)
			.opacity(0.4)
	}
	
	func regularStyle() -> Self {
		self
			.font(Font.custom("Lato-Regular", size: 14))
			.foregroundColor(UI.Color.gray)
	}
	
	func smallStyle() -> Self {
		self
			.font(Font.custom("Lato-Regular", size: 10))
			.foregroundColor(UI.Color.gray)
	}
}


extension Text {
	
	func attributeStyle() -> Self {
		self
			.font(Font.custom("Lato-Regular", size: 14))
			.foregroundColor(UI.Color.green)
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
}


extension Image {
	
	func backgroundStyle() -> some View {
		self
			.opacity(0.2)
	}
	
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
				UI.Color.gray.opacity(0.5)
					.overlay(
						LinearGradient(
							gradient: Gradient(
								colors: [
									.clear,
									UI.Color.green.opacity(0.2)
								]
							),
							startPoint: UnitPoint(x: 0, y: 0.7),
							endPoint: UnitPoint(x: 0, y: 1.0)
						)
					)
			)
	}
	
	fileprivate func listBackgroundStyle() -> some View {
		self
			.background(
				LinearGradient(
					gradient: Gradient(
						colors: [
							UI.Color.darkGray,
							UI.Color.mediumGray
						]
					),
					startPoint: .top,
					endPoint: .bottom
				)
					.opacity(0.5)
			)
	}
}
