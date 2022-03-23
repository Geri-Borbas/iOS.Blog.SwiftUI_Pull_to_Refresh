//
//  ForecastViewModel.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/03/2022.
//

import Foundation
import OpenWeather


class ForecastViewModel: ObservableObject, Identifiable {
		
	let id: String = UUID().uuidString
	let time: Date
	let imageName: String
	let temperature: Double
	let smallestTemperature: Double
	let greatestTemperature: Double
	let wind: Double
	
	init() {
		self.time = Date()
		self.imageName = "minus"
		self.temperature = 273.15
		self.smallestTemperature = 273.15
		self.greatestTemperature = 273.15
		self.wind = 0
	}
	
	init(
		weather: OpenWeather.HourlyForecast.WeatherData,
		smallestTemperature: Double,
		greatestTemperature: Double
	) {
		self.time = weather.time
		self.imageName = weather.imageName
		self.temperature = weather.temperature
		self.smallestTemperature = smallestTemperature
		self.greatestTemperature = greatestTemperature
		self.wind = weather.windSpeed
	}
}


extension ForecastViewModel {
	
	var celsius: Double {
		temperature - 273.15
	}
	
	var celsiusString: String {
		String(format: "%.1f °C", celsius)
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
