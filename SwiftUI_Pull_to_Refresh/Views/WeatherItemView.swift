//
//  WeatherItemView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 20/09/2021.
//

import Foundation
import SwiftUI
import OpenWeather


struct WeatherItemView: View {
	
	let viewModel: OpenWeather.HourlyForecast.WeatherData
	
	var body: some View {
		Text("\(viewModel.time), \(viewModel.displayTemperature)")
	}
}
