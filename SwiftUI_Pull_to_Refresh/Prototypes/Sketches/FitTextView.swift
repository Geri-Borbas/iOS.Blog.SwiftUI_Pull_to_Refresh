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
			VStack(spacing: 0) {
				Rectangle()
					.fill(Color.white.opacity(0.2))
					.frame(height: 40)
				Text("Lorem Ipsum")
					.font(Font.custom("Lato-Black", size: 80))
					.lineLimit(1)
					.minimumScaleFactor(0.01)
					.background(Color.red.opacity(0.2))
					.border(Color.red, width: 1)
				Text("Dolor sit amet")
					.font(Font.custom("Lato-Thin", size: 20))
					.background(Color.red.opacity(0.2))
					.border(Color.red, width: 1)
				Spacing()
			}
		}
		.preferredColorScheme(.dark)
	}
}
