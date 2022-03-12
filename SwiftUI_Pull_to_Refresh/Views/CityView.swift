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
	
	@ObservedObject var viewModel: CityViewModel
	let width: CGFloat
	
	var body: some View {
		VStack {
			
			// Title.
			Text(viewModel.name)
				.font(.largeTitle)
			
			// List.
			List {
				
				// Elements.
				switch viewModel.state {
				case .idle:
					Color.clear
				case .loading:
					ForEach(Array(repeating: 0, count: 100).indices, id: \.self) { _ in
						Text("Loading")
//							.redacted(reason: .placeholder)
					}
				case .error(let error):
					Text("Could not refresh weather data. \(error.localizedDescription)")
					ForEach(Array(repeating: 0, count: 100).indices, id: \.self) { _ in
						Text("Loading")
//							.redacted(reason: .placeholder)
					}
				case .loaded(let weather):
					Text(weather.currentWeather.displayTemperature)
						.font(.largeTitle)
					ForEach(weather.hourlyWeather.indices, id: \.self) { eachIndex in
						WeatherItemView(viewModel: weather.hourlyWeather[eachIndex])
					}
				}
				
			}
			.refreshControl { refreshControl in
				viewModel.fetch {
				   refreshControl.endRefreshing()
			   }
		   }
		}
		.frame(width: width)
		.onAppear {
			viewModel.fetch()
		}
	}
}
