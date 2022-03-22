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
	@Environment(\.screenFrame) var screenFrame: CGRect
	let width: CGFloat
	
	init(viewModel: CityViewModel, width: CGFloat) {
		self.viewModel = viewModel
		self.width = width
		setupAppearence()
	}
	
	var body: some View {
		VStack(spacing: 0) {
			TitleView(
				name: viewModel.display.name,
				dateAndTimeString: viewModel.display.dateAndTimeString
			)
			Spacing(UI.padding - topPadding)
			List {
				Section(
					header:
						DashboardView(
							imageName: viewModel.display.imageName,
							celsius: viewModel.display.celsius,
							description: viewModel.display.description,
							wind: viewModel.display.wind,
							humidity: viewModel.display.humidity,
							uv: viewModel.display.uv
						)
						.listRowInsets(.zero)
						.introspectTableViewHeaderFooterView {
							$0.backgroundView = UIView() // iOS 13
						},
					content: {
						ForEach(
							Array(viewModel.display.items.enumerated()),
							id: \.offset
						) { eachIndex, eachViewModel in
							RowView(
								isFirst: eachIndex == 0,
								isLast: eachIndex == viewModel.display.items.count - 1,
								viewModel: eachViewModel
							)
						}
					}
				)
			}
			.listStyle(.plain)
			.clipShape(RoundedRectangle(cornerRadius: UI.cornerRadius))
			.padding(.horizontal, UI.padding)
			.padding(.bottom, UI.padding)
			.edgesIgnoringSafeArea(.bottom) // iOS 13
			.environment(\.defaultMinListRowHeight, UI.rowHeight)
			.introspectTableView {
				$0.separatorStyle = .none // iOS 13
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


extension CityView {
	
	var topPadding: CGFloat {
		if #available(iOS 15.0, *) {
			return 8
		} else {
			return 0
		}
	}
	
	func setupAppearence() {
		
		// Tighten extra padding above section header (if any).
		if #available(iOS 15.0, *) {
			UITableView.appearance().sectionHeaderTopPadding = topPadding
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
