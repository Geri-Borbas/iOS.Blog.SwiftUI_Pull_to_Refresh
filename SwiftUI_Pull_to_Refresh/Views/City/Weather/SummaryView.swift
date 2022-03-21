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
		HStack {
			Image(systemName: imageName)
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
				Text(description)
					.subtitleStyle()
			}
		}
		.padding(.vertical, 20)
		.padding(.horizontal, 28)
		.featuredBackgroundStyle()
		.backgroundBlur(in: screenFrame)
		.cornerRadius(UI.cornerRadius)
	}
}
