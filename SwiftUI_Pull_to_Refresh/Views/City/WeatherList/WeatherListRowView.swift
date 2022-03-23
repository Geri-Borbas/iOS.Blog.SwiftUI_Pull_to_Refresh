//
//  WeatherListRowView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 20/03/2022.
//

import SwiftUI


struct WeatherListRowView: View {
	
	let isFirst: Bool
	let isLast: Bool
	let viewModel: ForecastViewModel
	@Environment(\.screenFrame) var screenFrame: CGRect
	
	var body: some View {
		return ForecastView(viewModel: viewModel)
			.listRowBackground(
				UI.Color.darkGray.opacity(0.5)
					.background(AlignedBackgroundView(blur: true, screenFrame: screenFrame))
					.clipShape(
						RowShape(isFirst: isFirst, isLast: isLast)
					)
					.padding(.bottom, bottomPadding)
			)
			.listRowInsets(insets)
	}
	
	var insets: EdgeInsets {
		if isFirst {
			return EdgeInsets(top: UI.padding / 2, leading: 0, bottom: 0, trailing: 0)
		} else if isLast {
			return EdgeInsets(top: 0, leading: 0, bottom: UI.padding / 2 + bottomPadding, trailing: 0)
		} else {
			return .zero
		}
	}
	
	var bottomPadding: CGFloat {
		if #available(iOS 14, *) {
			return 0
		} else {
			return isLast ? 16 : 0
		}
	}
}

struct RowShape: Shape {
	
	let isFirst: Bool
	let isLast: Bool
	
	// Returns either a top cap, a rectangle, or a bottom cap shape.
	func path(in rect: CGRect) -> Path {
		let path: UIBezierPath
		if isFirst {
			let enlarged = rect.with(minHeight: UI.cornerRadius * 2)
			path = UIBezierPath(
				roundedRect: enlarged,
				byRoundingCorners: [.topLeft, .topRight],
				cornerRadii: UI.cornerRadius.size
			)
			let hole = UIBezierPath(
				rect: CGRect(
					x: rect.origin.x,
					y: rect.origin.y + rect.height,
					width: rect.size.width,
					height: enlarged.size.height - rect.size.height
				)
			)
			path.append(hole.reversing())
		} else if isLast {
			let enlarged = rect.with(minHeight: UI.cornerRadius * 2)
			path = UIBezierPath(
				roundedRect: enlarged,
				byRoundingCorners: [.bottomLeft, .bottomRight],
				cornerRadii: UI.cornerRadius.size
			)
			let hole = UIBezierPath(
				rect: CGRect(
					x: rect.origin.x,
					y: rect.origin.y,
					width: rect.size.width,
					height: enlarged.size.height - rect.size.height
				)
			)
			path.append(hole.reversing())
			let translation = CGAffineTransform(translationX: 0, y: -(enlarged.size.height - rect.size.height))
			path.apply(translation)
		} else {
			path = UIBezierPath(rect: rect)
		}
		return Path(path.cgPath)
	}
}


extension CGFloat {
	
	var size: CGSize {
		.init(width: self, height: self)
	}
}


extension CGRect {
	
	func with(minHeight: CGFloat) -> CGRect {
		CGRect(
			origin: self.origin,
			size: .init(
				width: self.size.width,
				height: max(self.size.height, minHeight)
			)
		)
	}
}
