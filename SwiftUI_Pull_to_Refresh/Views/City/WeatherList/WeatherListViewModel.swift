//
//  WeatherListViewModel.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 22/03/2022.
//

import Foundation
import OpenWeather


struct WeatherListViewModel {
	
	let time: Date
	let imageName: String
	let celsius: String
	let description: String
	let wind: String
	let humidity: String
	let uv: String
	let items: [ForecastViewModel]
}


extension WeatherListViewModel {
	
	init(from hourlyForecast: OpenWeather.HourlyForecast, name: String) {
		let weather = hourlyForecast.currentWeather
		self.time = weather.time
		self.imageName = weather.imageName
		self.celsius = String(format: "%.1f", weather.temperature - 273.15)
		self.description = weather.description
		self.wind = String(format: "%.2f", weather.windSpeed)
		self.humidity = String(format: "%.0f", weather.humidity)
		self.uv = String(format: "%.1f", weather.uvIndex)
		self.items = hourlyForecast.hourlyWeather.map { ForecastViewModel(weather: $0) }
	}
	
	static let empty = WeatherListViewModel(
		time: Date(),
		imageName: "cloud.bolt.rain",
		celsius: "0",
		description: "Few clouds",
		wind: "0.71",
		humidity: "31",
		uv: "1.2",
		items: Array(repeating: 1, count: 20).map { _ in ForecastViewModel() }
	)
	
	var dateAndTimeString: String {
		DateFormatter().with {
			$0.dateFormat = "E MMM d 'at' HH:mm"
		}.string(from: time)
	}
}
