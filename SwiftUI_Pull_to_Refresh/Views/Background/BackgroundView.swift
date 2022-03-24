//
//  BackgroundView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 23/03/2022.
//

import SwiftUI


struct BackgroundView: View {
	
	var body: some View {
		baked
	}
	
	var blank: some View {
		UI.Color.background
	}
	
	var baked: some View {
		UI.Color.background
			.overlay(
				VStack {
					UI.Image.opaqueBackground
					Spacer()
				}
			)
			.clipped()
	}
	
	var transparent: some View {
		UI.Color.background
			.overlay(
				VStack {
					UI.Image.background
						.backgroundStyle()
					Spacer()
				}
			)
	}
}
