//
//  FitTextView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 21/03/2022.
//

import SwiftUI


extension View {
	
	func heroStyle(black: Bool = true) -> some View {
		self
			.font(Font.custom(black ? "Lato-Black" : "Lato-Regular", size: 68))
			.foregroundColor(UI.Color.foreground)
			.frame(maxHeight: 64)
	}
}


struct FitTextView: View {
	
	static let screenFrame = CGRect(
		x: 0,
		y: 44,
		width: 375,
		height: 812 - 44
	)
	
	var body: some View {
		ZStack {
			Rectangle()
				.fill(ImagePaint(image: Image("10pt")))
				.opacity(0.2)
			VStack {
				WeatherView(
					imageName: "text.book.closed.fill",
					celsius: "-65.4",
					description: "Few Clouds",
					wind: "0.71",
					humidity: "85",
					uv: "1.2"
				)
					.redLine(opacity: 0.5)
				Spacer()
			}
			.padding(.horizontal, UI.padding)
			.redLine(opacity: 0.5)
		}
		.preferredColorScheme(.dark)
	}
}


extension View {
	
	func redLine(opacity: CGFloat = 1.0) -> some View {
		self
			.background(Color.red.opacity(0.2 * opacity))
			.border(Color.red.opacity(opacity), width: 1)
	}
}
