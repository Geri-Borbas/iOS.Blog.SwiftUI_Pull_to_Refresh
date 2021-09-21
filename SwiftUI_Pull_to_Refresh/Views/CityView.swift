//
//  CityView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 21/09/2021.
//

import Foundation
import SwiftUI
import OpenWeather


struct CityView: View {
	
	let name: String
	let location: OpenWeather.Location
	let width: CGFloat
	
	@ObservedObject var viewModel: WeatherViewModel
	
	var body: some View {
		VStack {
			Text(name)
				.font(.largeTitle)
			List {
				ForEach(viewModel.weather(for: location).indices, id: \.self) { eachIndex in
					WeatherItemView(viewModel: viewModel.weather(for: location)[eachIndex])
				}
			}
			.frame(width: width)
			.redacted(reason: viewModel.isLoading ? .placeholder : .init())
			.refreshControl { refreshControl in
				viewModel.fetchWeather(at: location) {
					refreshControl.endRefreshing()
				}
			}
		}
		.onAppear {
			viewModel.fetchWeather(at: location)
		}
	}
}
