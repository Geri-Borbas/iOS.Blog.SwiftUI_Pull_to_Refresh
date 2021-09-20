//
//  WeatherView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI
import OpenWeather


struct WeatherView: View {
	
	let sanFrancisco = OpenWeather.Location(latitude: 37.7749, longitude: 122.4194)
	let london = OpenWeather.Location(latitude: 51.5074, longitude: 0.1278)
	
	@StateObject var viewModel = WeatherViewModel()
	
	var body: some View {
		GeometryReader { geometry in
			ScrollView(.horizontal) {
				HStack {
					VStack {
						Text("San Francisco")
							.font(.largeTitle)
						List {
							ForEach(viewModel.weather(for: sanFrancisco).indices, id: \.self) { eachIndex in
								WeatherItemView(viewModel: viewModel.weather(for: sanFrancisco)[eachIndex])
							}
						}
						.frame(width: geometry.size.width)
						.redacted(reason: viewModel.isLoading ? .placeholder : .init())
						.refreshControl { refreshControl in
							viewModel.fetchWeather(at: sanFrancisco) {
								refreshControl.endRefreshing()
							}
						}
					}
					VStack {
						Text("London")
							.font(.largeTitle)
						List {
							ForEach(viewModel.weather(for: london).indices, id: \.self) { eachIndex in
								WeatherItemView(viewModel: viewModel.weather(for: london)[eachIndex])
							}
						}
						.frame(width: geometry.size.width)
						.redacted(reason: viewModel.isLoading ? .placeholder : .init())
						.refreshControl { refreshControl in
							viewModel.fetchWeather(at: london) {
								refreshControl.endRefreshing()
							}
						}
					}
				}
			}
			.onAppear {
				viewModel.fetchWeather(at: sanFrancisco)
				viewModel.fetchWeather(at: london)
			}
		}
	}
}
