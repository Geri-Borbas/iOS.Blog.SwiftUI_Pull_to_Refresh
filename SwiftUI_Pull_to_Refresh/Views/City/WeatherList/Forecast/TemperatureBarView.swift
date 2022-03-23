//
//  TemperatureBarView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 22/03/2022.
//

import SwiftUI


struct TermperatureBarView: View {
	
	private let negativePercentage: CGFloat
	private let positivePercentage: CGFloat
	private let scale: CGFloat
	
	init(
		temperature: Double,
		smallestTemperature: Double,
		greatestTemperature: Double
	) {
		// Conversion.
		let smallestCelsius = smallestTemperature - 273.15
		let greatestCelsius = greatestTemperature - 273.15
		let celsius = temperature - 273.15
		
		// Determine scale.
		let celsiusLimit = max(-smallestCelsius, greatestCelsius)
		switch celsiusLimit {
		case 0...10 : self.scale = 10
		case 10...20 : self.scale = 20
		case 20...30 : self.scale = 30
		case 30...40 : self.scale = 40
		default: self.scale = celsiusLimit
		}
		
		// Scale display values.
		self.negativePercentage = celsius <= 0
			? celsius / -scale
			: .leastNonzeroMagnitude
		self.positivePercentage = celsius >= 0
			? celsius / scale
			: .leastNonzeroMagnitude
	}
	
	var body: some View {
		HStack(spacing: UI.lineWidth) {
			RoundedRectangle(cornerRadius: UI.lineWidth / 2.0)
				.foregroundColor(UI.Color.gray.opacity(0.1))
				.frame(height: UI.lineWidth)
				.overlay(
					GeometryReader { geometry in
						HStack {
							Spacer()
							RoundedRectangle(cornerRadius: UI.lineWidth)
								.foregroundColor(UI.Color.gray)
								.frame(
									width: geometry.size.width * negativePercentage,
									height: UI.lineWidth
								)
						}
					}
				)
			RoundedRectangle(cornerRadius: UI.lineWidth / 2.0)
				.foregroundColor(UI.Color.green.opacity(0.1))
				.frame(height: UI.lineWidth)
				.overlay(
					GeometryReader { geometry in
						HStack {
							RoundedRectangle(cornerRadius: UI.lineWidth)
								.foregroundColor(UI.Color.green.opacity(0.5))
								.frame(
									width: geometry.size.width * positivePercentage,
									height: UI.lineWidth
								)
							Spacer()
						}
					}
				)
		}
	}
}
