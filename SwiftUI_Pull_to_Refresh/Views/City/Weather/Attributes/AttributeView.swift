//
//  AttributeView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct AttributeView: View {
	
	let image: String
	let name: String
	let value: String
	let unit: String
	
	var body: some View {
		HStack(spacing: 4) {
			Image(systemName: image)
				.iconStyle()
			VStack(alignment: .leading, spacing: 0) {
				Text(name)
					.attributeStyle()
				HStack(alignment: .bottom, spacing: 2) {
					Text(value)
						.valueStyle()
					Text(unit)
						.unitStyle()
				}
			}
		}
	}
}
