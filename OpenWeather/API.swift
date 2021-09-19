//
//  API.swift
//  OpenWeather
//
//  Created by Geri Borbás on 19/09/2021.
//

import Foundation


public enum APIError: Error {
	case wrongUrl
	case noData
	case wrongJSON
}


/// From https://openweathermap.org/api/one-call-api
public struct API {
	
	public static func get(
		at location: Location = .init(latitude: 33.44, longitude: -94.04),
		completion: @escaping (_ result: Result<[String: Any], Error>) -> Void
		) {
		
		// Query.
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.openweathermap.org"
		components.path = "/data/2.5/onecall"
		components.queryItems = [
			.init(name: "lat", value: String(location.latitude)),
			.init(name: "lon", value: String(location.longitude)),
			.init(name: "exclude", value: "minutely,daily,alerts"), // current,hourly
			.init(name: "appid", value: "9ef3309fd13bb2c83a3cea4b8b68afda") // Be my guest
		]
		guard let url = components.url else {
			return completion(.failure(APIError.wrongUrl))
		}
		
		// Request.
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		
		// Task.
		URLSession(configuration: URLSessionConfiguration.ephemeral).dataTask(
			with: request,
			completionHandler: { data, _, error in
				DispatchQueue.main.async {
					if let error = error {
						print("error: \(error)")
						completion(.failure(error))
					} else if let data = data {
						do {
							if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
								print("response: \(String(decoding: data, as: UTF8.self))")
								completion(.success(response))
							} else {
								print("error: \(APIError.wrongJSON)")
								completion(.failure(APIError.wrongJSON))
							}
						} catch {
							print("error: \(error)")
							completion(.failure(error))
						}
					} else {
						print("error: \(APIError.noData)")
						completion(.failure(APIError.noData))
					}
				}
			}
		).resume()
	}
}
