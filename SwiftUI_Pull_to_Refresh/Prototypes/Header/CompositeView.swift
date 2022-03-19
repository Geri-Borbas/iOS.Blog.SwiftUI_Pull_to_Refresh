//
//  CompositeView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/03/2022.
//

import SwiftUI
import Introspect


struct CompositeView: View {
	
	struct Metrics {
		
		static let title = CGFloat(80)
		static let header = CGFloat(160)
	}
	
	init() {
		UITableViewHeaderFooterView.appearance().backgroundView = UIView()
	}
	
	var body: some View {
		ZStack {
			
			// Background.
			Color.clear
				.overlay(
					VStack {
						Image("WorldMap").opacity(0.2)
						Spacer()
					}
				)
			
			Color.red.opacity(0.2)
			
			// List.
			VStack {
				Spacing(Metrics.title + Metrics.header)
				List {
					ForEach(1...20, id: \.self) { eachRowIndex in
						Text("Row \(eachRowIndex)")
							.listRowBackground(Color.clear)
							.listRowInsets(EdgeInsets())
					}
				}
				.listStyle(.plain)
				.background(Color.orange.opacity(0.2))
				.clipShape(
					RoundedRectangle(cornerRadius: 25 + 16)
						.inset(by: 16+16)
				)
				.refreshable {
					
				}
				.padding(.horizontal, 16)

			}

			// Foreground.
			VStack(spacing: 0) {

				// City header.
				VStack {
					Text("City").titleStyle()
					Text("Date and Time").subtitleStyle()
				}
				.frame(height: Metrics.title)

				// Weather.
				HStack {
					Spacer()
					Text("Weather")
					Spacer()
				}
					.frame(height: Metrics.header)
					.featuredBackgroundStyle()

				// List.
				GeometryReader { _ in
					Color.red
						.cornerRadius(25)
						.opacity(0.2)
						.allowsHitTesting(false)
				}

				Spacing(16)
			}
			.padding(.horizontal, 16)
		}
		.edgesIgnoringSafeArea(.bottom)
	}
}
