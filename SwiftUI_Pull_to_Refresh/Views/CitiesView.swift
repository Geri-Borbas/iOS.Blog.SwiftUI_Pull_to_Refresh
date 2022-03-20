//
//  CitiesView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI
import Introspect
import OpenWeather


private struct CitiesFrameEnvironmentKey: EnvironmentKey {
	static let defaultValue: CGRect = .zero
}

extension EnvironmentValues {
	var citiesFrame: CGRect {
		get { self[CitiesFrameEnvironmentKey.self] }
		set { self[CitiesFrameEnvironmentKey.self] = newValue }
	}
}


struct CitiesView: View {
	
	let viewModel = CitiesViewModel()
	
	var body: some View {
		ZStack {
			
			// Background.
			UI.Color.background
				.overlay(
					VStack {
						UI.Image.background
							.backgroundStyle()
						Spacer()
					}
				)
			
			// Cities.
			GeometryReader { geometry in
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 0) {
						ForEach(viewModel.cities) { eachCityViewModel in
							CityView(
								viewModel: CityViewModel(
									name: eachCityViewModel.name,
									location: .init(
										latitude: eachCityViewModel.location.latitude,
										longitude: eachCityViewModel.location.longitude
									)
								),
								width: geometry.size.width
							)
								.environment(\.citiesFrame, geometry.frame(in: .global))
						}
					}
				}
				.introspectScrollView {
					$0.isPagingEnabled = true
				}
			}
		}
		.edgesIgnoringSafeArea(.bottom)
		.preferredColorScheme(.dark)
	}
}
