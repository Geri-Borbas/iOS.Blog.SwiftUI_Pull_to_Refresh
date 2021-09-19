//
//  HourlyForecast.swift
//  OpenWeather
//
//  Created by Geri Borbás on 19/09/2021.
//

import Foundation


/// From https://openweathermap.org/api/one-call-api
public struct HourlyForecast: Decodable {
	
	public let latitude: Double
	public let longitude: Double
	public let timezone: String
	public let timezoneOffset: Int
	public let currentWeather: WeatherData
	public let hourlyWeather: [WeatherData]
	
	enum CodingKeys: String, CodingKey {
		case latitude = "lat"
		case longitude = "lon"
		case timezone = "timezone"
		case timezoneOffset = "timezone_offset"
		case currentWeather = "current"
		case hourlyWeather = "hourly"
	}
	
	public struct WeatherData: Decodable {
		
		public let time: Date
		public let sunriseTime: Date?
		public let sunsetTime: Date?
		public let temperature: Double
		public let temperatureFeelsLike: Double
		public let pressure: Double
		public let humidity: Double
		public let dewPoint: Double
		public let clouds: Double
		public let uvIndex: Double
		public let visibility: Double
		public let windSpeed: Double
		public let windGust: Double?
		public let windDirection: Double
		public let precipitationProbability: Double?
		public let rain: Volume?
		public let snow: Volume?
		public let weather: [Weather]
		
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
		
		public struct Volume: Decodable {
			
			public let volumeLastHour: Double
			
			enum CodingKeys: String, CodingKey {
				case volumeLastHour = "1h"
			}
		}
		
		public struct Weather: Decodable {

			public let id: Int
			public let main: String
			public let description: String
			public let icon: String
		}
	}
}
