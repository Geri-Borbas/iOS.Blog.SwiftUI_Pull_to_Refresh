//
//  ForecastView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 20/09/2021.
//

import Foundation
import SwiftUI


struct ForecastView: View {
	
	let viewModel: ForecastViewModel
	
	var body: some View {
		HStack(spacing: 8) {
			
			// Date and time.
			VStack(alignment: .leading, spacing: 0) {
				Text(viewModel.timeString)
					.regularStyle()
				Text(viewModel.dateString)
					.smallStyle()
					.frame(width: 60, alignment: .leading)
			}
			.frame(width: 60)
			.redLine(opacity: 0.2)
			
			// Icon.
			HStack {
				Image(systemName: viewModel.imageName)
					.iconStyle()
				Spacer()
			}
			.frame(width: 38)
			.redLine(opacity: 0.2)
						
			// Temperature.
			VStack(alignment: .leading, spacing: 2) {
				Text(viewModel.celsiusString)
					.regularStyle()
				TermperatureBarView(
					temperature: viewModel.temperature,
					smallestTemperature: viewModel.smallestTemperature,
					greatestTemperature: viewModel.greatestTemperature
				)
			}
			.redLine(opacity: 0.2)
			
			// Wind.
			WindBarView(wind: viewModel.wind)
			.redLine(opacity: 0.2)
			
		}
		.frame(height: UI.rowHeight)
		.padding(.horizontal, UI.padding)
	}
}
