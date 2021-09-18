//
//  API.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/09/2021.
//

import Foundation


enum APIError: Error {
	case wrongUrl
	case noData
}


struct API {
	
	static func get(symbol: String = "AAPL", completion: @escaping (_ result: Result<IntradayTimeSeries, Error>) -> Void) {
		
		// Query.
		var components = URLComponents()
		components.scheme = "https"
		components.host = "www.alphavantage.co"
		components.path = "/query"
		components.queryItems = [
			.init(name: "function", value: "TIME_SERIES_INTRADAY"),
			.init(name: "symbol", value: symbol),
			.init(name: "interval", value: "1min"),
			.init(name: "outputsize", value: "compact"),
			.init(name: "apikey", value: "AAPNSNB308FRK2Z9") // Be my guest
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
							let response = try JSONDecoder().decode(IntradayTimeSeries.self, from: data)
							completion(.success(response))
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
