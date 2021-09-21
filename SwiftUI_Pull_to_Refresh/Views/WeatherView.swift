//
//  WeatherView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI
import OpenWeather


struct WeatherView: View {
		
	@StateObject var viewModel = WeatherViewModel()
	
	var body: some View {
		GeometryReader { geometry in
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 0) {
					CityView(
						name: "San Francisco",
						location: .init(latitude: 37.7749, longitude: 122.4194),
						width: geometry.size.width,
						viewModel: viewModel
					)
					CityView(
						name: "New York",
						location: .init(latitude: 40.7128, longitude: 74.0060),
						width: geometry.size.width,
						viewModel: viewModel
					)
					CityView(
						name: "Paris",
						location: .init(latitude: 48.8566, longitude: 2.3522),
						width: geometry.size.width,
						viewModel: viewModel
					)
					CityView(
						name: "London",
						location: .init(latitude: 51.5074, longitude: 0.1278),
						width: geometry.size.width,
						viewModel: viewModel
					)
					CityView(
						name: "Moscow",
						location: .init(latitude: 55.7558, longitude: 37.6173),
						width: geometry.size.width,
						viewModel: viewModel
					)
					CityView(
						name: "New Delhi",
						location: .init(latitude: 28.6139, longitude: 77.2090),
						width: geometry.size.width,
						viewModel: viewModel
					)
					CityView(
						name: "Tokyo",
						location: .init(latitude: 35.6762, longitude: 139.6503),
						width: geometry.size.width,
						viewModel: viewModel
					)
					CityView(
						name: "Sidney",
						location: .init(latitude: 33.8688, longitude: 151.2093),
						width: geometry.size.width,
						viewModel: viewModel
					)
					CityView(
						name: "Honolulu",
						location: .init(latitude: 21.3069, longitude: 157.8583),
						width: geometry.size.width,
						viewModel: viewModel
					)
				}
			}
			.paging()
		}
		.edgesIgnoringSafeArea(.bottom)
	}
}
