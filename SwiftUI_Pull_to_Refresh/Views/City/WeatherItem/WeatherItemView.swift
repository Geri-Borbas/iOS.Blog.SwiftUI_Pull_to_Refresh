//
//  WeatherItemView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 20/09/2021.
//

import Foundation
import SwiftUI


struct WeatherItemView: View {
	
	let viewModel: WeatherItemViewModel
	
	var body: some View {
		Text(viewModel.displayString)
			.secondaryStyle()
	}
}
