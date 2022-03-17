//
//  CityView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 21/09/2021.
//

import Foundation
import SwiftUI
import OpenWeather


@MainActor
struct CityView: View {
	
	@ObservedObject var viewModel: CityViewModel
	let width: CGFloat
	
	var body: some View {
		VStack {
			
			// Title.
			Text(viewModel.name)
				.font(Font.custom("Lato-Light", size: 40))
			
			// List.
			List {
				
				// Elements.
				switch viewModel.state {
				case .idle:
					Color.clear
				case .loading:
					Text("Loading")
						.font(.largeTitle)
					ForEach(Array(repeating: 0, count: 20).indices, id: \.self) { _ in
						Text("Loading")
					}
				case .error(let error):
					Text("Could not refresh weather data. \(error.localizedDescription)")
					ForEach(Array(repeating: 0, count: 20).indices, id: \.self) { _ in
						Text("Loading")
					}
				case .loaded(let weather):
					Text(weather.currentWeather.displayTemperature)
						.font(.largeTitle)
					ForEach(weather.hourlyWeather.indices, id: \.self) { eachIndex in
						WeatherItemView(viewModel: weather.hourlyWeather[eachIndex])
					}
				}
				
			}
			.refreshable {
				await viewModel.fetch()
			}
		}
		.frame(width: width)
		.onAppear {
			viewModel.fetch()
		}
	}
}
