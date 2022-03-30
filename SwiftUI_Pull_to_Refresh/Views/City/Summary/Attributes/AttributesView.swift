//
//  AttributesView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct AttributesView: View {
	
	let wind: String
	let humidity: String
	let uv: String
	
	var body: some View {
		HStack(spacing: spacing) {
			Spacer()
			AttributeView(
				image: "wind",
				name: "Wind",
				value: wind,
				unit: "Km/h"
			)
			AttributeView(
				image: humidityImageName,
				name: "Humidity",
				value: humidity,
				unit: "%"
			)
			AttributeView(
				image: "sun.max",
				name: "UV Index",
				value: uv,
				unit: ""
			)
			Spacer()
		}
		.padding(.vertical, 16)
	}
	
	var spacing: CGFloat {
		UIScreen.main.bounds.size.width < 390 ? 10 : 20
	}
	
	var humidityImageName: String {
		if #available(iOS 14.0, *) {
			return "drop"
		} else {
			return "cloud.fog"
		}
	}
}
