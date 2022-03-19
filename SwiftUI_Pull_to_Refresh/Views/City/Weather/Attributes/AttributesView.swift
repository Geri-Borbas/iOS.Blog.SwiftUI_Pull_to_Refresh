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
		HStack(spacing: 10) {
			Spacer()
			AttributeView(
				image: "wind",
				name: "Wind",
				value: wind,
				unit: "Km/h"
			)
			AttributeView(
				image: "drop",
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
}
