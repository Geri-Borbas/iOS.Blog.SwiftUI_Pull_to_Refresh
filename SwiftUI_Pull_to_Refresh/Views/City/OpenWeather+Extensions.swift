//
//  OpenWeather+Extensions.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 20/03/2022.
//

import Foundation
import OpenWeather


extension OpenWeather.HourlyForecast {
	
	var description: String {
		currentWeather.weather.description
	}
}


extension OpenWeather.HourlyForecast.WeatherData {
	
	var description: String {
		weather.first?.main ?? ""
	}
	
	// From https://openweathermap.org/weather-conditions
	var imageName: String {
		guard let icon = weather.first?.icon else {
			return "questionmark.circle"
		}
		
		switch icon {
		// clear sky
		case "01d": return "sun.max"
		case "01n": return "moon.stars"
		// few clouds
		case "02d": return "cloud.sun"
		case "02n": return "cloud.moon"
		// scattered clouds
		case "03d": return "cloud"
		case "03n": return "cloud"
		// broken clouds
		case "04d": return "smoke"
		case "04n": return "smoke"
		// shower rain
		case "09d": return "cloud.rain"
		case "09n": return "cloud.rain"
		// rain
		case "10d": return "cloud.sun.rain"
		case "10n": return "cloud.moon.rain"
		// thunderstorm
		case "11d": return "cloud.bolt.rain"
		case "11n": return "cloud.bolt.rain"
		// snow
		case "13d": return "snow"
		case "13n": return "snow"
		// mist
		case "50d": return "cloud.fog"
		case "50n": return "cloud.fog"
		default: return "questionmark.circle"
		}
	}
}
