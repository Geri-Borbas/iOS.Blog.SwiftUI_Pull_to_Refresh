//
//  WeatherView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct WeatherView: View {
	
	let celsius: String
	let wind: String
	let humidity: String
	let uv: String
	
	@Environment(\.citiesFrame) var citiesFrame: CGRect
	
	var body: some View {
		VStack(spacing: 0) {
			SummaryView(
				celsius: celsius
			)
			AttributesView(
				wind: wind,
				humidity: humidity,
				uv: uv
			)
		}
			.background(
				GeometryReader { geometry in
					worldMap(geometry: geometry)
				}
			)
	}
	
	private func worldMap(geometry: GeometryProxy) -> some View {
		UI.Color.background
			.overlay(
				UI.Image.worldMap
					.opacity(0.5)
					.offset(
						x: -geometry.frame(in: .global).origin.x + citiesFrame.origin.x + UI.Spacing.screen,
						y: -geometry.frame(in: .global).origin.y + citiesFrame.origin.y
					), alignment: .top
			)
			.frame(height: CoverShape.shapeHeight(for: geometry.size.height))
			.clipShape(CoverShape())
	}
}


struct CoverShape: Shape {
	
	static func shapeHeight(for height: CGFloat) -> CGFloat {
		height + UI.cornerRadius * 2
	}
	
	func path(in rect: CGRect) -> Path {
		let path = UIBezierPath(rect: rect)
		let hole = UIBezierPath(
			roundedRect: .init(
				x: rect.origin.x,
				y: rect.maxY - UI.cornerRadius * 2,
				width: rect.width,
				height: UI.cornerRadius * 2
			),
			byRoundingCorners: [.topLeft, .topRight],
			cornerRadii: UI.cornerRadius.size
		)
		path.append(hole.reversing())
		return Path(path.cgPath)
	}
}


extension CGFloat {
	
	var size: CGSize {
		.init(width: self, height: self)
	}
}
