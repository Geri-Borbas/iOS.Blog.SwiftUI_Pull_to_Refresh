//
//  CityView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 21/09/2021.
//

import Foundation
import SwiftUI
import Introspect
import OpenWeather


struct CityView: View {
	
	@ObservedObject var viewModel: CityViewModel
	let width: CGFloat
	
	init(viewModel: CityViewModel, width: CGFloat) {
		self.viewModel = viewModel
		self.width = width
		setupAppearence()
	}
	
	var body: some View {
		VStack(spacing: 0) {
			TitleView(
				name: viewModel.name,
				dateAndTimeString: viewModel.weatherListViewModel.dateAndTimeString
			)
			Spacer(minLength: UI.padding - UI.topPadding)
			WeatherList(viewModel: viewModel.weatherListViewModel)
				.refreshable {
					await viewModel.fetch()
				}
		}
		.frame(width: width)
		.onAppear {
			viewModel.fetch()
		}
	}
}


extension CityView {
	
	func setupAppearence() {
		
		// Tighten extra padding above section header (if any).
		if #available(iOS 15.0, *) {
			UITableView.appearance().sectionHeaderTopPadding = UI.topPadding
		}
		
		// Hide indicators, separators.
		UITableView.appearance().showsVerticalScrollIndicator = false
		UITableView.appearance().separatorColor = .clear
		
		// iOS 13.
		UITableView.appearance().backgroundColor = .clear
		UITableViewCell.appearance().backgroundColor = .clear
		
		// Transparent section header.
		UITableViewHeaderFooterView.appearance().backgroundView = UIView()
	}
}
