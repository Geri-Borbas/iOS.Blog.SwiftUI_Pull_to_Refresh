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
	static let useMockData = true
	
	@Published var weatherListViewModel: WeatherListViewModel = .empty
	
	enum State {
		
		case idle
		case loading
		case error(error: Error)
		case loaded(weather: HourlyForecast)
	}
	
	@Published var state: State = .loading
	
	init(name: String, location: Location) {
		self.name = name
		self.location = location
	}
	
	func fetch() async {
		await withCheckedContinuation { continuation in
			fetch {
				DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Some extra (fake) loading
					continuation.resume()
				}
			}
		}
	}
	
	func fetch(completion: (() -> Void)? = nil) {
		
		// Can spare API rate during UI development.
		if Self.useMockData {
			let mock = OpenWeather.HourlyForecast.mock(for: name)
			self.state = .loaded(weather: mock)
			self.weatherListViewModel = .init(from: mock, name: self.name)
			completion?()
			return
		}
		
		state = .loading
		OpenWeather.API.get(at: location) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let weather):
				self.state = .loaded(weather: weather)
				self.weatherListViewModel = .init(from: weather, name: self.name)
			case .failure(let error):
				self.state = .error(error: error)
				self.weatherListViewModel = .empty
			}
			completion?()
		}
	}
}


extension CityViewModel.State {
	
//	var isLoading: Bool {
//		switch self {
//		case .loading:
//			return true
//		default:
//			return false
//		}
//	}
}
