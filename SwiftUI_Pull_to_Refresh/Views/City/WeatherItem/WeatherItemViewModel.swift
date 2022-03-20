//
//  WeatherItemViewModel.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/03/2022.
//

import Foundation
import OpenWeather


class WeatherItemViewModel: ObservableObject, Identifiable {
		
	let id: String = UUID().uuidString
	let time: Date
	let icon: String?
	let temperature: Double
	
	init() {
		self.time = Date()
		self.icon = nil
		self.temperature = 273.15
	}
	
	init(weather: OpenWeather.HourlyForecast.WeatherData) {
		self.time = weather.time
		self.icon = weather.weather.first?.icon
		self.temperature = weather.temperature
	}
}


extension WeatherItemViewModel {
	
	var temperatureString: String {
		String(format: "%.1f °C", temperature - 273.15)
	}
	
	var dateString: String {
		DateFormatter().with {
			$0.dateFormat = "EEE MMM d"
		}.string(from: time)
	}
	
	var timeString: String {
		DateFormatter().with {
			$0.dateFormat = "HH:mm"
		}.string(from: time)
	}
}
