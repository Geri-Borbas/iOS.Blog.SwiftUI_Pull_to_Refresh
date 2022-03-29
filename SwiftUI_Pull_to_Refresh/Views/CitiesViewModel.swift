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
			location: .init(latitude: 37.773972, longitude: -122.431297)
		),
		.init(
			name: "New York",
			location: .init(latitude: 40.730610, longitude: -73.935242)
		),
		.init(
			name: "Paris",
			location: .init(latitude: 48.864716, longitude: 2.349014)
		),
		.init(
			name: "London",
			location: .init(latitude: 51.509865, longitude: -0.118092)
		),
		.init(
			name: "Moscow",
			location: .init(latitude: 55.751244, longitude: 37.618423)
		),
		.init(
			name: "New Delhi",
			location: .init(latitude: 28.644800, longitude: 77.216721)
		),
		.init(
			name: "Tokyo",
			location: .init(latitude: 35.652832, longitude: 139.839478)
		),
		.init(
			name: "Sidney",
			location: .init(latitude: -33.865143, longitude: 151.209900)
		),
		.init(
			name: "Honolulu",
			location: .init(latitude: 21.315603, longitude: -157.858093)
		)
	]
}
