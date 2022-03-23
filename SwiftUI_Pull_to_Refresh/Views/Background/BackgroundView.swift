//
//  BackgroundView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 23/03/2022.
//

import SwiftUI


struct AlignedBackgroundView: View {
	
	let blur: Bool
	let screenFrame: CGRect
	
	var body: some View {
		baked
	}
	
	var blank: some View {
		UI.Color.background
	}
	
	var baked: some View {
		GeometryReader { geometry in
			baked(geometry: geometry, screenFrame: screenFrame)
		}
	}
	
	func baked(geometry: GeometryProxy, screenFrame: CGRect) -> some View {
		UI.Color.background
			.overlay(
				(blur ? UI.Image.opaqueBackgroundWithBlur : UI.Image.opaqueBackground)
					.offset(
						x: -geometry.frame(in: .global).origin.x + screenFrame.origin.x + UI.padding,
						y: -geometry.frame(in: .global).origin.y + screenFrame.origin.y
					), alignment: .top
			)
			.clipped()
	}
	
	var dynamic: some View {
		GeometryReader { geometry in
			dynamic(geometry: geometry, screenFrame: screenFrame)
		}
	}
	
	func dynamic(geometry: GeometryProxy, screenFrame: CGRect) -> some View {
		UI.Color.background
			.overlay(
				UI.Image.background
					.backgroundStyle()
					.background(UI.Color.background)
					.blur(radius: blur ? UI.Image.blur : 0)
					.offset(
						x: -geometry.frame(in: .global).origin.x + screenFrame.origin.x + UI.padding,
						y: -geometry.frame(in: .global).origin.y + screenFrame.origin.y
					), alignment: .top
			)
	}
}


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
