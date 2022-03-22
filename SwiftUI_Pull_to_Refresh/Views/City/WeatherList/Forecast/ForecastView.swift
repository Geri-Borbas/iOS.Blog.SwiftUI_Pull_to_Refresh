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
			HStack {
				VStack(alignment: .leading, spacing: 0) {
					Text(viewModel.timeString)
						.regularStyle()
						.fixedSize()
					Text(viewModel.dateString)
						.smallStyle()
						.fixedSize()
				}
				Spacer()
			}
			.frame(width: 60)
			
			// Icon.
			HStack {
				Image(systemName: viewModel.imageName)
					.iconStyle()
				Spacer()
			}
			.frame(width: 34)
			
			// Temperature.
			HStack {
				Text(viewModel.celsiusString)
					.largeStyle()
				Spacer()
			}
			.frame(width: 80)
			
			// Temperature bar.
			TermperatureBarView(
				temperature: viewModel.temperature,
				smallestTemperature: viewModel.smallestTemperature,
				greatestTemperature: viewModel.greatestTemperature
			)
			
		}
		.frame(height: UI.rowHeight)
		.padding(.horizontal, UI.padding)
	}
}
