//
//  OpenWeather+Mocks.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 22/03/2022.
//

import Foundation
import OpenWeather


extension OpenWeather.HourlyForecast {
		
	static func mock(for city: String) -> OpenWeather.HourlyForecast {
		
		// File.
		guard let jsonFilePath =
				Bundle.main.path(forResource: city, ofType: "json") ??
				Bundle.main.path(forResource: "San Francisco", ofType: "json") else {
			preconditionFailure("Mock JSON is missing.")
		}
		
		// String.
		let jsonString: String
		do {
			jsonString = try String(contentsOfFile: jsonFilePath)
		} catch {
			preconditionFailure("Can't read mock JSON.")
		}
		
		// Data.
		guard let jsonData = jsonString.data(using: .utf8) else {
			preconditionFailure("Could not get mock JSON data.")
		}
		
		// Decode.
		let weather: OpenWeather.HourlyForecast
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		do {
			weather = try decoder.decode(HourlyForecast.self, from: jsonData)
		} catch {
			preconditionFailure("Could not decode mock JSON data.")
		}
		
		return weather
	}
}
