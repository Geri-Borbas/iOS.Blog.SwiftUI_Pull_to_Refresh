//
//  SummaryView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct SummaryView: View {
	
	let celsius: String
	
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
	}
}
