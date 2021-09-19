//
//  HourlyForecast+Preview.swift
//  OpenWeather
//
//  Created by Geri Borbás on 20/09/2021.
//

import Foundation


public extension HourlyForecast {
	
	static let preview = from(json: "HourlyForecast")
	
	static func from(json jsonFileName: String) -> HourlyForecast {
		guard let path = Bundle.current.path(forResource: jsonFileName, ofType: "json") else {
			preconditionFailure("Could not find `\(jsonFileName).json` in bundle.")
		}
		do {
			if let data = try String(contentsOfFile: path).data(using: .utf8) {
				let decoded = try JSONDecoder().decode(HourlyForecast.self, from: data)
				return decoded
			} else {
				preconditionFailure("Could not read `\(jsonFileName).json`.")
			}
		} catch {
			preconditionFailure("Could not decode `\(jsonFileName).json`. \(error)")
		}
	}
}
