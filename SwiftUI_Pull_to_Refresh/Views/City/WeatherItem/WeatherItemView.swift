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
				Text(viewModel.temperatureString)
					.largeStyle()
				Spacer()
			}
			.frame(width: 76)
			
			Spacer()
		}
		.frame(height: UI.rowHeight)
		.padding(.horizontal, UI.padding)
	}
}
