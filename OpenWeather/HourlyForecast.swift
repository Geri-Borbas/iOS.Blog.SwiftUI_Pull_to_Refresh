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
	let currentWeather: WeatherData
	let hourlyWeather: [WeatherData]
	
	enum CodingKeys: String, CodingKey {
		case latitude = "lat"
		case longitude = "lon"
		case timezone = "timezone"
		case timezoneOffset = "timezone_offset"
		case currentWeather = "current"
		case hourlyWeather = "hourly"
	}
	
	struct WeatherData: Decodable {
		
		let time: Date
		let sunriseTime: Date?
		let sunsetTime: Date?
		let temperature: Double
		let temperatureFeelsLike: Double
		let pressure: Double
		let humidity: Double
		let dewPoint: Double
		let clouds: Double
		let uvIndex: Double
		let visibility: Double
		let windSpeed: Double
		let windGust: Double?
		let windDirection: Double
		let precipitationProbability: Double?
		let rain: Volume?
		let snow: Volume?
		let weather: [Weather]
		
		enum CodingKeys: String, CodingKey {
			case time = "dt"
			case sunriseTime = "sunrise"
			case sunsetTime = "sunset"
			case temperature = "temp"
			case temperatureFeelsLike = "feels_like"
			case pressure = "pressure"
			case humidity = "humidity"
			case dewPoint = "dew_point"
			case clouds = "clouds"
			case uvIndex = "uvi"
			case visibility = "visibility"
			case windSpeed = "wind_speed"
			case windGust = "wind_gust"
			case windDirection = "wind_deg"
			case precipitationProbability = "pop"
			case rain = "rain"
			case snow = "snow"
			case weather = "weather"
		}
		
		struct Volume: Decodable {
			
			let volumeLastHour: Double
			
			enum CodingKeys: String, CodingKey {
				case volumeLastHour = "1h"
			}
		}
		
		struct Weather: Decodable {

			let id: Int
			let main: String
			let description: String
			let icon: String
		}
	}
}
