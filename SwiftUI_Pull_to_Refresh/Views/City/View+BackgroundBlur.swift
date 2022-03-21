//
//  View+BackgroundBlur.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 21/03/2022.
//

import SwiftUI


extension View {
	
	func backgroundBlur(in screenFrame: CGRect) -> some View {
		self.background(
			GeometryReader { geometry in
				background(geometry: geometry, screenFrame: screenFrame)
			}
		)
	}
	
	func background(geometry: GeometryProxy, screenFrame: CGRect) -> some View {
		UI.Color.background
			.overlay(
				UI.Image.background
					.backgroundStyle()
					.background(UI.Color.background)
					.blur(radius: UI.Image.blur)
					.offset(
						x: -geometry.frame(in: .global).origin.x + screenFrame.origin.x + UI.padding,
						y: -geometry.frame(in: .global).origin.y + screenFrame.origin.y
					), alignment: .top
			)
	}
}
