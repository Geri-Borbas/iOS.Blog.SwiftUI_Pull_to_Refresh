//
//  SummaryView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct SummaryView: View {
	
	let celsius: String
	@Environment(\.citiesFrame) var citiesFrame: CGRect
	
	var body: some View {
		HStack {
			Image(systemName: "cloud.bolt.rain")
				.heroStyle()
			Spacer(minLength: 30)
			VStack(alignment: .leading, spacing: 0) {
				HStack {
					Text(celsius)
						.heroStyle()
						.layoutPriority(1)
						.minimumScaleFactor(0.6)
					Text("°C")
						.heroStyle(black: false)
						.minimumScaleFactor(0.6)
					Spacer()
				}
				Text("Few Clouds")
					.regularStyle()
			}
		}
		.padding(.vertical, 20)
		.padding(.horizontal, 28)
		.featuredBackgroundStyle()
		.background(
			GeometryReader { geometry in
				background(geometry: geometry)
			}
		)
		.cornerRadius(UI.cornerRadius)
	}
	
	private func background(geometry: GeometryProxy) -> some View {
		UI.Color.background
			.overlay(
				UI.Image.background
					.backgroundStyle()
					.background(UI.Color.background)
					.blur(radius: UI.Image.blur)
					.offset(
						x: -geometry.frame(in: .global).origin.x + citiesFrame.origin.x + UI.Spacing.screen,
						y: -geometry.frame(in: .global).origin.y + citiesFrame.origin.y
					), alignment: .top
			)
	}
}
