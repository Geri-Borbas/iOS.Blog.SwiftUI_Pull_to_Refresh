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


@MainActor
struct CityView: View {
	
	@ObservedObject var viewModel: CityViewModel
	let width: CGFloat
	
	init(viewModel: CityViewModel, width: CGFloat) {
		self.viewModel = viewModel
		self.width = width
		UITableViewHeaderFooterView.appearance().backgroundView = UIView()
	}
	
	var body: some View {
		VStack(spacing: 0) {
			
			// City header.
			Text(viewModel.name)
				.titleStyle()
			Text(viewModel.display.timeString)
				.subtitleStyle()
			Spacing(12)
			
			// List.
			List {
				
				
				Section(
					
					// Weather header.
					header: VStack {
						HStack {
							Image(systemName: "cloud.bolt.rain")
								.heroStyle()
							Spacing(30)
							VStack(alignment: .leading, spacing: 0) {
								HStack {
									Text(viewModel.display.celsius)
										.heroStyle()
										.layoutPriority(1)
										.minimumScaleFactor(0.6)
									Text("°C")
										.heroStyle(black: false)
										.minimumScaleFactor(0.6)
									Spacer()
								}
								Text("Few Clouds")
									.regularStyle()
							}
						}
						.padding(.vertical, 20)
						.padding(.horizontal, 28)
						.background(
							Color("Gray")
								.overlay(
									LinearGradient(
										gradient: Gradient(
											colors: [.clear, Color("Green").opacity(0.2)]),
										startPoint: UnitPoint(x: 0, y: 0.7),
										endPoint: UnitPoint(x: 0, y: 1.0)
									)
								)
						)
						.cornerRadius(32)
						Spacer(minLength: 16)
					}
						.listRowInsets(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
						.listRowBackground(Color.clear),
					
					// Hourly forecast list.
					content: {
						ForEach(viewModel.display.items) { eachViewModel in
							WeatherItemView(viewModel: eachViewModel)
								.listRowBackground(Color.clear)
						}
					}
				)
			}
			.listStyle(.plain)
			.introspectTableView {
				$0.separatorStyle = .none
				$0.showsVerticalScrollIndicator = false
			}
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


fileprivate struct Spacing: View {
	
	let minLength: CGFloat?
	
	init(_ minLength: CGFloat? = nil) {
		self.minLength = minLength
	}
	
	var body: some View {
		Spacer(minLength: minLength)
	}
}
