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
					Color.red
						.opacity(0.2)
						.frame(height: MaskShape.shapeHeight(for: geometry.size.height))
						.clipShape(MaskShape())
				}
			)
	}
}


struct MaskShape: Shape {
	
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
