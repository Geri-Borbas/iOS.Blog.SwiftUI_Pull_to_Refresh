//
//  WeatherView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct WeatherView: View {
	
	let imageName: String
	let celsius: String
	let description: String
	let wind: String
	let humidity: String
	let uv: String
	@Environment(\.screenFrame) var screenFrame: CGRect
	
	var body: some View {
		VStack(spacing: 0) {
			SummaryView(
				imageName: imageName,
				celsius: celsius,
				description: description
			)
				.environment(\.screenFrame, screenFrame)
			AttributesView(
				wind: wind,
				humidity: humidity,
				uv: uv
			)
		}
		.background(
			GeometryReader { geometry in
				background(geometry: geometry)
					.mask(
						LinearGradient(
							gradient: Gradient(
								colors: [
									.white.opacity(1.0),
									.white.opacity(0.4)
								]
							),
							startPoint: UnitPoint(x: 0, y: 0.4),
							endPoint: UnitPoint(x: 0, y: 1.0)
						)
					)
			}
		)
	}
	
	private func background(geometry: GeometryProxy) -> some View {
		UI.Color.background
			.overlay(
				UI.Image.background
					.backgroundStyle()
					.offset(
						x: -geometry.frame(in: .global).origin.x + screenFrame.origin.x + UI.padding,
						y: -geometry.frame(in: .global).origin.y + screenFrame.origin.y
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
