//
//  ContentView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI


struct ContentView: View {
	
	@State var appleTimeSeries: IntradayTimeSeries = .empty
	@State var teslaTimeSeries: IntradayTimeSeries = .empty
	@State var appleIsLoading = false
	@State var teslaIsLoading = false
	
	var body: some View {
		VStack {
			HStack {
				List {
					ForEach(1...100, id: \.self) { eachRowIndex in
						Text("Left \(eachRowIndex)")
					}
				}
				.redacted(reason: appleIsLoading ? .placeholder : .init())
				.refreshControl { refreshControl in
					appleIsLoading = true
					API.get(symbol: "AAPL") { result in
						switch result {
						case .success(let response):
							self.appleTimeSeries = response
						case .failure(_):
							break
						}
						appleIsLoading = false
						refreshControl.endRefreshing()
					}
				}
				List {
					ForEach(1...100, id: \.self) { eachRowIndex in
						Text("Right \(eachRowIndex)")
					}
				}
				.redacted(reason: teslaIsLoading ? .placeholder : .init())
				.refreshControl { refreshControl in
					teslaIsLoading = true
					API.get(symbol: "TSLA") { result in
						switch result {
						case .success(let response):
							self.teslaTimeSeries = response
						case .failure(_):
							break
						}
						teslaIsLoading = false
						refreshControl.endRefreshing()
					}
				}
			}
		}
		.onAppear {
			appleIsLoading = true
			API.get(symbol: "AAPL") { result in
				switch result {
				case .success(let response):
					self.appleTimeSeries = response
				case .failure(_):
					break
				}
				appleIsLoading = false
			}
			teslaIsLoading = true
			API.get(symbol: "TSLA") { result in
				switch result {
				case .success(let response):
					self.teslaTimeSeries = response
				case .failure(_):
					break
				}
				teslaIsLoading = false
			}
		}
	}
}
