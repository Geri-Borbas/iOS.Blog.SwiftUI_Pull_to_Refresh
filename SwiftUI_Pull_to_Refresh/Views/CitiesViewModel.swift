//
//  CitiesViewModel.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 20/03/2022.
//

import Foundation


class CitiesViewModel {
	
	struct City: Identifiable {
		
		let name: String
		let location: Location
		
		struct Location {
			
			let latitude: Double
			let longitude: Double
		}
		
		var id: String {
			name
		}
	}
	
	let cities: [City] = [
		.init(
			name: "San Francisco",
			location: .init(latitude: 37.7749, longitude: 122.4194)
		),
		.init(
			name: "New York",
			location: .init(latitude: 40.7128, longitude: 74.0060)
		),
		.init(
			name: "Paris",
			location: .init(latitude: 48.8566, longitude: 2.3522)
		),
		.init(
			name: "London",
			location: .init(latitude: 51.5074, longitude: 0.1278)
		),
		.init(
			name: "Moscow",
			location: .init(latitude: 55.7558, longitude: 37.6173)
		),
		.init(
			name: "New Delhi",
			location: .init(latitude: 28.6139, longitude: 77.2090)
		),
		.init(
			name: "Tokyo",
			location: .init(latitude: 35.6762, longitude: 139.6503)
		),
		.init(
			name: "Sidney",
			location: .init(latitude: 33.8688, longitude: 151.2093)
		),
		.init(
			name: "Honolulu",
			location: .init(latitude: 21.3069, longitude: 157.8583)
		)
	]
}
