//
//  WeatherItemViewModel.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/03/2022.
//

import Foundation
import OpenWeather


class WeatherItemViewModel: ObservableObject {
		
	let time: Date
	let icon: String?
	let temperature: Double
	
	init() {
		self.time = Date()
		self.icon = nil
		self.temperature = 0
	}
	
	init(weather: OpenWeather.HourlyForecast.WeatherData) {
		self.time = weather.time
		self.icon = weather.weather.first?.icon
		self.temperature = weather.temperature
	}
}


extension WeatherItemViewModel: Identifiable {
	
	var id: Double {
		time.timeIntervalSince1970
	}
}


extension WeatherItemViewModel {
	
	var displayString: String {
		let time = DateFormatter().with {
			$0.dateStyle = .medium
			$0.timeStyle = .short
		}.string(from: time)
		let temperature = String(format: "%.1f °C", temperature - 273.15)
		return "\(time), \(temperature)"
	}
}
