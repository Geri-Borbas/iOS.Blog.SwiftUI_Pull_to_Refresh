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
	@Environment(\.citiesFrame) var citiesFrame: CGRect
	let width: CGFloat
	
	init(viewModel: CityViewModel, width: CGFloat) {
		self.viewModel = viewModel
		self.width = width
		setupAppearence()
	}
	
	var body: some View {
		VStack(spacing: 0) {
//			TitleView(
//				name: viewModel.name,
//				dateAndTimeString: viewModel.display.timeString
//			)
//			Spacing(UI.Spacing.screen - topPadding)
			List {
				Section(
					header:
						WeatherView(
							celsius: viewModel.display.celsius,
							wind: viewModel.display.wind,
							humidity: viewModel.display.humidity,
							uv: viewModel.display.uv
						)
						.allowsHitTesting(false)
						.listRowInsets(EdgeInsets()),
					content: {
						ForEach(viewModel.display.items) { eachViewModel in
							WeatherItemView(viewModel: eachViewModel)
								.listRowBackground(Color("Dark Gray").opacity(0.5))
								.listRowInsets(EdgeInsets())
						}
					}
				)
			}
			.listStyle(.plain)
			.introspectTableView {
				$0.separatorStyle = .none
			}
			.refreshable {
				await viewModel.fetch()
			}
			.clipShape(ListShape())
			.padding(.horizontal, UI.Spacing.screen)
			.padding(.bottom, UI.Spacing.screen)
		}
		.frame(width: width)
		.onAppear {
			viewModel.fetch()
		}
	}
}


struct ListShape: Shape {
		
	func path(in rect: CGRect) -> Path {
		Path(
			UIBezierPath(
				roundedRect: rect,
				byRoundingCorners: [.bottomLeft, .bottomRight],
				cornerRadii: UI.cornerRadius.size
			).cgPath
		)
	}
}


extension CityView {
	
	var topPadding: CGFloat {
		if #available(iOS 15.0, *) {
			return 8
		} else {
			return 0
		}
	}
	
	func setupAppearence() {
		
		// Tighten extra padding above section header.
		if #available(iOS 15.0, *) {
			UITableView.appearance().sectionHeaderTopPadding = topPadding
		}
		
		// Hide scroll indicators.
		UITableView.appearance().showsVerticalScrollIndicator = false
		
		// Transparent section header (iOS 14+).
		UITableViewHeaderFooterView.appearance().backgroundView = UIView()
	}
}
