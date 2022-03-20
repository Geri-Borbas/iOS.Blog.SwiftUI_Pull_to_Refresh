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
		let wind: String
		let humidity: String
		let uv: String
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
		
		// Can spare API rate during UI development.
		let spare = false
		if spare {
			self.state = .error(error: OpenWeather.APIError.noData)
			self.display = Display.empty
			completion?()
			return
		}
		
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
		self.wind = String(format: "%.2f", weather.windSpeed)
		self.humidity = String(format: "%.0f", weather.humidity)
		self.uv = String(format: "%.1f", weather.uvIndex)
		self.items = hourlyForecast.hourlyWeather.map { WeatherItemViewModel(weather: $0) }
	}
	
	var dateAndTimeString: String {
		DateFormatter().with {
			$0.dateFormat = "E MMM d 'at' HH:mm"
		}.string(from: time)
	}
}


extension CityViewModel.Display {
	
	static let empty = CityViewModel.Display(
		time: Date(),
		celsius: "0",
		wind: "0.71",
		humidity: "31",
		uv: "1.2",
		items: Array(repeating: 1, count: 20).map { _ in WeatherItemViewModel() }
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
