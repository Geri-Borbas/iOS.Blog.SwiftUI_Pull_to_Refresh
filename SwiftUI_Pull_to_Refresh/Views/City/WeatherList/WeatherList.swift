//
//  WeatherList.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 22/03/2022.
//

import SwiftUI


struct WeatherList: View {
	
	let viewModel: WeatherListViewModel
	
	var body: some View {
		List {
			Section(
				header:
					SummaryView(
						imageName: viewModel.imageName,
						celsius: viewModel.celsius,
						description: viewModel.description,
						wind: viewModel.wind,
						humidity: viewModel.humidity,
						uv: viewModel.uv
					)
					.listRowInsets(.zero)
					.introspectTableViewHeaderFooterView {
						$0.backgroundView = UIView() // iOS 13
					},
				content: {
					ForEach(
						Array(viewModel.items.enumerated()),
						id: \.offset
					) { eachIndex, eachViewModel in
						WeatherListRowView(
							isFirst: eachIndex == 0,
							isLast: eachIndex == viewModel.items.count - 1,
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
			$0.set(speed: UI.speed)
		}
	}
}
