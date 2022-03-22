//
//  DashboardView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct DashboardView: View {
	
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
				.environment(\.screenFrame, screenFrame)
			AttributesView(
				wind: wind,
				humidity: humidity,
				uv: uv
			)
		}
		.background(
			GeometryReader { geometry in
				background(geometry: geometry)
					.mask(
						LinearGradient(
							gradient: Gradient(
								colors: [
									.white.opacity(1.0),
									.white.opacity(0.0)
								]
							),
							startPoint: UnitPoint(x: 0, y: 0.4),
							endPoint: UnitPoint(x: 0, y: 1.0)
						)
					)
			}
		)
	}
	
	private func background(geometry: GeometryProxy) -> some View {
		UI.Color.background
			.overlay(
				UI.Image.background
					.backgroundStyle()
					.offset(
						x: -geometry.frame(in: .global).origin.x + screenFrame.origin.x + UI.padding,
						y: -geometry.frame(in: .global).origin.y + screenFrame.origin.y
					), alignment: .top
			)
			.redLine()
	}
}


extension DashboardView {
	
	static let mock = DashboardView(
		imageName: "cloud.bolt.rain",
		celsius: "-165.4",
		description: "Few clouds",
		wind: "0.71",
		humidity: "85",
		uv: "1.2"
	)
}
