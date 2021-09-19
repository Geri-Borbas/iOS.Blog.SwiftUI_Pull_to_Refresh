//
//  ContentView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI
import OpenWeather


struct ContentView: View {
	
	// TODO: Wrap this up to a view model.
	@State var weather: [String: Any] = [:]
	@State var weatherIsLoading = false
	
	// 37.7749° N, 122.4194
	
	var body: some View {
		VStack {
			HStack {
				List {
					ForEach(1...100, id: \.self) { eachRowIndex in
						Text("Left \(eachRowIndex)")
					}
				}
				.redacted(reason: weatherIsLoading ? .placeholder : .init())
				.refreshControl { refreshControl in
					weatherIsLoading = true
					API.get { result in
						switch result {
						case .success(let response):
							self.weather = response
						case .failure(_):
							break
						}
						weatherIsLoading = false
						refreshControl.endRefreshing()
					}
				}
				List {
					ForEach(1...100, id: \.self) { eachRowIndex in
						Text("Right \(eachRowIndex)")
					}
				}
				.redacted(reason: weatherIsLoading ? .placeholder : .init())
				.refreshControl { refreshControl in
					weatherIsLoading = true
					API.get { result in
						switch result {
						case .success(let response):
							self.weather = response
						case .failure(_):
							break
						}
						weatherIsLoading = false
						refreshControl.endRefreshing()
					}
				}
			}
		}
		.onAppear {
			weatherIsLoading = true
			API.get { result in
				switch result {
				case .success(let response):
					self.weather = response
				case .failure(_):
					break
				}
				weatherIsLoading = false
			}
		}
	}
}
