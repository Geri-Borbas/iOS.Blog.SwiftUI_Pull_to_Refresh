//
//  TemperatureView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct TemperatureView: View {
	
	let imageName: String
	@State var celsius: String
	let description: String
	@Environment(\.screenFrame) var screenFrame: CGRect
	
	@State private var testStrings = [
		"",
		"-38.0",
		"-12.0",
		"24.0",
		"12.0",
		"1.0",
		"2.0",
		"4.0",
		"12.0",
		"-45.0",
		"-165.4",
		"-237.15"
	]
	
	var body: some View {
		HStack(spacing: 30) {
			Image(systemName: imageName)
				.heroStyle()
				.redLine()
			VStack(alignment: .leading, spacing: 0) {
				Color.clear
					.frame(height: 64, alignment: .bottom)
					.overlay(
						Group {
							Text("\(celsius) °C")
								.heroStyle()
								.lineLimit(1)
								.fixedSize(horizontal: false, vertical: true)
								.minimumScaleFactor(0.2)
								.redLine()
							}
							.frame(maxWidth: .infinity, alignment: .bottomLeading)
							.offset(x: 0, y: -4)
							.redLine()
					)
					.redLine()
				Text(description)
					.subtitleStyle()
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
		.onTapGesture {
			celsius = testStrings.popLast() ?? "0"
		}
	}
}
