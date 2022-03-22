//
//  TemperatureView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct TemperatureView: View {
	
	let imageName: String
	let celsius: String
	let description: String
	@Environment(\.screenFrame) var screenFrame: CGRect
	
	var body: some View {
		HStack(spacing: 30) {
			Image(systemName: imageName)
				.heroStyle()
				.redLine()
			VStack(alignment: .leading, spacing: 0) {
				Text("\(celsius) °C")
					.heroStyle()
					.lineLimit(1)
					.fixedSize(horizontal: false, vertical: true)
					.minimumScaleFactor(0.2)
					.redLine()
				Text(description)
					.subtitleStyle()
					.removeTextCase()
					.offset(x: 0, y: -6)
					.redLine()
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.redLine(opacity: 0.5)
		}
		.padding(.vertical, 20)
		.padding(.horizontal, 28)
		.featuredBackgroundStyle()
		.backgroundBlur(in: screenFrame)
		.cornerRadius(UI.cornerRadius)
		.redLine(opacity: 0.5)
	}
}


extension View {
	
	func eraseToAnyView() -> AnyView {
			AnyView(self)
		}
	
	func removeTextCase() -> some View {
		if #available(iOS 14.0, *) {
			return self
				.textCase(.none)
				.eraseToAnyView()
		} else {
			return self
				.eraseToAnyView()
		}
	}
}
