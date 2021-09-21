//
//  CityViewModel.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 21/09/2021.
//

import Foundation
import OpenWeather


class CityViewModel: ObservableObject {
	
	let name: String
	let location: OpenWeather.Location
	
	enum State {
		
		case idle
		case loading
		case error(error: Error)
		case loaded(weather: HourlyForecast)
	}
	
	@Published var state: State = .loading
	
	init(name: String, location: Location) {
		self.name = name
		self.location = location
	}
	
	func fetch(completion: (() -> Void)? = nil) {
		state = .loading
		OpenWeather.API.get(at: location) { [weak self] result in
			switch result {
			case .success(let response):
				self?.state = .loaded(weather: response)
			case .failure(let error):
				self?.state = .error(error: error)
			}
			completion?()
		}
	}
}


extension CityViewModel.State {
	
	var isLoading: Bool {
		switch self {
		case .loading:
			return true
		default:
			return false
		}
	}
}


extension OpenWeather.HourlyForecast.WeatherData {
	
	var displayTemperature: String {
		String(format: "%.2f °C", temperature - 273.15)
	}
}
