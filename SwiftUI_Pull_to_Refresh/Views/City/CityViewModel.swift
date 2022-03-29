//
//  CityViewModel.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 21/09/2021.
//

import Foundation
import OpenWeather


class CityViewModel: ObservableObject {
	
	let name: String
	let location: OpenWeather.Location
	static let useMockData = false
	
	@Published var weatherListViewModel: WeatherListViewModel = .empty
	
	init(name: String, location: Location) {
		self.name = name
		self.location = location
	}
	
	func fetch() async {
		await withCheckedContinuation { continuation in
			fetch {
				DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 / Double(UI.speed.layerSpeed)) { // Some extra (fake) loading
					continuation.resume()
				}
			}
		}
	}
	
	func fetch(completion: (() -> Void)? = nil) {
		
		// Can spare API rate during UI development.
		if Self.useMockData {
			let mock = OpenWeather.HourlyForecast.mock(for: name)
			self.weatherListViewModel = .init(from: mock, name: self.name)
			completion?()
			return
		}
		
		OpenWeather.API.get(at: location) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let weather):
				self.weatherListViewModel = .init(from: weather, name: self.name)
			case .failure(_):
				self.weatherListViewModel = .empty
			}
			completion?()
		}
	}
}
