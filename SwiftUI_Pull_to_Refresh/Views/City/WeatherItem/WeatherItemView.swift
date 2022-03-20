//
//  WeatherItemView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 20/09/2021.
//

import Foundation
import SwiftUI


struct WeatherItemView: View {
	
	let viewModel: WeatherItemViewModel
	
	var body: some View {
		HStack(spacing: 8) {
			VStack(alignment: .leading, spacing: 0) {
				Text(viewModel.timeString)
					.regularStyle()
				Text(viewModel.dateString)
					.smallStyle()
			}
			Image(systemName: "cloud.bolt.rain")
				.iconStyle()
			Text(viewModel.temperatureString)
				.largeStyle()
		}
		.frame(height: UI.rowHeight)
		.padding(.horizontal, UI.padding)
	}
}
