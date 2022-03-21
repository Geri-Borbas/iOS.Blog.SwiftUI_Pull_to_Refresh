//
//  FitTextView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 21/03/2022.
//

import SwiftUI


struct FitTextView: View {
	
	@State var minimumScaleFactor: CGFloat = 0.01
	
	var body: some View {
		ZStack {
			Rectangle()
				.fill(ImagePaint(image: Image("10pt")))
				.opacity(0.2)
			VStack {
				HStack(spacing: 30) {
					Image(systemName: "text.book.closed.fill")
						.heroStyle()
						.redLine()
					VStack(alignment: .leading, spacing: 0) {
						Text("-65.4 °C")
							.heroStyle()
							.lineLimit(1)
							.minimumScaleFactor(minimumScaleFactor)
							.redLine()
						Text("Dolor sit amet")
							.subtitleStyle()
							.lineLimit(1)
							.redLine()
					}
					.redLine(opacity: 0.5)
				}
				.padding(30)
				.redLine(opacity: 0.5)
				Spacing()
				Slider(value: $minimumScaleFactor, in: 0...1)
			}
			.redLine(opacity: 0.5)
		}
		.preferredColorScheme(.dark)
	}
}


extension View {
	
	func redLine(opacity: CGFloat = 1.0) -> some View {
		self
			.background(Color.red.opacity(0.2 * opacity))
			.border(Color.red.opacity(opacity), width: 1)
	}
}
