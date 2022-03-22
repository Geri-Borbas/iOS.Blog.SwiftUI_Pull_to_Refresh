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
				Text(viewModel.temperatureString)
					.largeStyle()
				Spacer()
			}
			.frame(width: 80)
			
			// Temperature bar.
			HStack(spacing: 2) {
				RoundedRectangle(cornerRadius: 2)
					.foregroundColor(UI.Color.gray.opacity(0.2))
					.frame(height: 2)
					.overlay(
						GeometryReader { geometry in
							HStack {
								Spacer()
								RoundedRectangle(cornerRadius: 2)
									.foregroundColor(UI.Color.gray)
									.frame(
										width: geometry.size.width * negativePercentage,
										height: 2
									)
							}
						}
					)
				RoundedRectangle(cornerRadius: 2)
					.foregroundColor(UI.Color.gray.opacity(0.2))
					.frame(height: 2)
					.overlay(
						GeometryReader { geometry in
							HStack {
								RoundedRectangle(cornerRadius: 2)
									.foregroundColor(UI.Color.green)
									.frame(
										width: geometry.size.width * positivePercentage,
										height: 2
									)
								Spacer()
							}
						}
					)
			}
		}
		.frame(height: UI.rowHeight)
		.padding(.horizontal, UI.padding)
	}
	
	var negativePercentage: CGFloat {
		0.5
	}
	
	var positivePercentage: CGFloat {
		0.5
	}
}
