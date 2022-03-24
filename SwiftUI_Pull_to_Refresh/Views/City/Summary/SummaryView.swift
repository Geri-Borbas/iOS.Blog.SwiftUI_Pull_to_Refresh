//
//  SummaryView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct SummaryView: View {
	
	let imageName: String
	let celsius: String
	let description: String
	let wind: String
	let humidity: String
	let uv: String
	@Environment(\.screenFrame) var screenFrame: CGRect
	
	var body: some View {
		VStack(spacing: 0) {
			TemperatureView(
				imageName: imageName,
				celsius: celsius,
				description: description
			)
				.frame(maxWidth: .infinity) // Occupy the entire `Section.header`
			AttributesView(
				wind: wind,
				humidity: humidity,
				uv: uv
			)
		}
		.background(
			AlignedBackgroundView(blur: false, screenFrame: screenFrame)
				.mask(
					LinearGradient(
						gradient:
							Gradient(
								stops: [
									.init(color: .white.opacity(1.0), location: 0.0),
									.init(color: .white.opacity(0.6), location: 0.5),
									.init(color: .white.opacity(0.0), location: 1.0)
								]
							),
						startPoint: UnitPoint(x: 0, y: 0.65),
						endPoint: UnitPoint(x: 0, y: 1.0)
					)
				)
		)
	}
}


extension SummaryView {
	
	static let mock = SummaryView(
		imageName: "cloud.bolt.rain",
		celsius: "-165.4",
		description: "Few clouds",
		wind: "0.71",
		humidity: "85",
		uv: "1.2"
	)
}
