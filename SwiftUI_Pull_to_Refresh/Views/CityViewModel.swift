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
	
	struct Display {
		
		let time: Date
		let celsius: String
		let items: [WeatherItemViewModel]
	}
	
	@Published var display: Display = .empty
	
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
	
	func fetch() async {
		await withCheckedContinuation { continuation in
			fetch {
				DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Some extra (fake) loading
					continuation.resume()
				}
			}
		}
	}
	
	func fetch(completion: (() -> Void)? = nil) {
		state = .loading
		OpenWeather.API.get(at: location) { [weak self] result in
			switch result {
			case .success(let weather):
				self?.state = .loaded(weather: weather)
				self?.display = Display(from: weather)
			case .failure(let error):
				self?.state = .error(error: error)
				self?.display = Display.empty
			}
			completion?()
		}
	}
}


extension CityViewModel.Display {
	
	init(from hourlyForecast: OpenWeather.HourlyForecast) {
		let weather = hourlyForecast.currentWeather
		self.time = weather.time
		self.celsius = String(format: "%.1f", weather.temperature - 273.15)
		self.items = hourlyForecast.hourlyWeather.map { WeatherItemViewModel(weather: $0) }
	}
	
	var timeString: String {
		DateFormatter().with {
			$0.dateStyle = .medium
			$0.timeStyle = .short
		}.string(from: time)
	}
}


extension CityViewModel.Display {
	
	static let empty = CityViewModel.Display(
		time: Date(),
		celsius: "0",
		items: Array(repeating: WeatherItemViewModel(), count: 20)
	)
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
