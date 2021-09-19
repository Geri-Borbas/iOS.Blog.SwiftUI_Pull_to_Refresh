//
//  WeatherViewModel.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 20/09/2021.
//

import Foundation
import OpenWeather


class WeatherViewModel: ObservableObject {
	
	@Published var isLoading: Bool = false
	@Published var weather: [Location: [HourlyForecast.WeatherData]] = [:]
	
	func fetchWeather(at location: OpenWeather.Location, completion: (() -> Void)? = nil) {
		isLoading = true
		OpenWeather.API.get(at: location) { [weak self] result in
			switch result {
			case .success(let response):
				self?.weather[location] = [response.currentWeather] + response.hourlyWeather
			case .failure(_):
				break
			}
			self?.isLoading = false
			completion?()
		}
	}
	
	func weather(for location: Location) -> [HourlyForecast.WeatherData] {
		weather[location] ?? []
	}
}
