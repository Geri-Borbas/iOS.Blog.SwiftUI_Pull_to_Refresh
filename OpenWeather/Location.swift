//
//  Location.swift
//  OpenWeather
//
//  Created by Geri Borbás on 19/09/2021.
//

import Foundation


public struct Location {
	
	let latitude: Double
	let longitude: Double
	
	public init(latitude: Double, longitude: Double) {
		self.latitude = latitude
		self.longitude = longitude
	}
}


extension Location: Hashable {
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(latitude)
		hasher.combine(longitude)
	}
}
