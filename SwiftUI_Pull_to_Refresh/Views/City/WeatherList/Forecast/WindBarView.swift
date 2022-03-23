//
//  WindBarView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 23/03/2022.
//

import SwiftUI


struct WindBarView: View {
	
	private let wind: String
	private let scale: Double = 40 // Km/h
	private static let count = 8
	private var capsules: [Bool] = Array(repeating: false, count: Self.count)
	
	init(wind: Double) {
		self.wind = String(format: "%.1f", wind)
		self.capsules = capsules.enumerated().map { eachIndex, _ -> Bool in
			let eachMinimum = Double(eachIndex) * scale / Double(capsules.count)
			return wind > eachMinimum
		}
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 2) {
			HStack(spacing: 2) {
				Text(wind)
					.smallStyle()
				Text("Km/h")
					.smallStyle()
					.opacity(0.5)
			}
			HStack(alignment: .bottom, spacing: 2) {
				ForEach(capsules.indices, id: \.self) { eachIndex in
					RoundedRectangle(cornerRadius: 2)
						.foregroundColor(UI.Color.gray.opacity(capsules[eachIndex] ? 0.8 : 0.2))
						.frame(width: 4, height: 4 + CGFloat(eachIndex))
				}
			}
		}
	}
}
