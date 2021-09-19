//
//  HourlyForecast.swift
//  OpenWeather
//
//  Created by Geri Borbás on 19/09/2021.
//

import Foundation


/// From https://openweathermap.org/api/one-call-api
public struct HourlyForecast: Decodable {
	
	let latitude: Double
	let longitude: Double
	let timezone: String
	let timezoneOffset: Int
	let currentWeather: Weather
	
	enum CodingKeys: String, CodingKey {
		case latitude = "lat"
		case longitude = "lon"
		case timezone = "timezone"
		case timezoneOffset = "timezone_offset"
		case currentWeather = "current"
	}
	
	struct Weather: Decodable {
		
		let time: Date
		let sunriseTime: Date
		let sunsetTime: Date
		let temperature: Double
		let temperatureFeelsLike: Double
		let pressure: Double
		let humidity: Double
		let dewPoint: Double
		
		enum CodingKeys: String, CodingKey {
			case time = "dt"
			case sunriseTime = "sunrise"
			case sunsetTime = "sunset"
			case temperature = "temp"
			case temperatureFeelsLike = "feels_like"
			case pressure = "pressure"
			case humidity = "humidity"
			case dewPoint = "dew_point"
		}
	}
}
