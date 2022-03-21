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
					.minimumScaleFactor(0.2)
					.redLine()
					.offset(x: 0, y: 2)
				Text(description)
					.subtitleStyle()
					.redLine()
					.offset(x: 0, y: -2)
			}
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
