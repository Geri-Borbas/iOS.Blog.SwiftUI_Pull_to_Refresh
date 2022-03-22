//
//  FitTextView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 21/03/2022.
//

import SwiftUI


struct FitTextView: View {
	
	var body: some View {
		ZStack {
			Rectangle()
				.fill(ImagePaint(image: Image("10pt")))
				.opacity(0.2)
			VStack {
				TitleView.mock
				List {
					Section(
						header: SummaryView.mock
							.listRowInsets(.zero),
						content: {
							ForEach(1...20, id: \.self) { eachRowIndex in
								Text("Row \(eachRowIndex)")
									.listRowBackground(
										Color.clear
											.redLine(opacity: 0.5)
									)
							}
						}
					)
				}
				.listStyle(.plain)
				.redLine(opacity: 0.5)
			}
			.padding(.horizontal, UI.padding)
			.redLine(opacity: 0.5)
		}
		.preferredColorScheme(.dark)
	}
}


extension View {
	
	func redLine(opacity: CGFloat = 1.0) -> some View {
		self
//			.background(Color.red.opacity(0.2 * opacity))
//			.border(Color.red.opacity(opacity), width: 1)
	}
}
