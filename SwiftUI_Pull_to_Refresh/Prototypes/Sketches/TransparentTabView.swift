//
//  TransparentTabView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct TransparentTabView: View {
	
	init() {
		let transparentAppearence = UITabBarAppearance()
		transparentAppearence.configureWithTransparentBackground()
		UITabBar.appearance().standardAppearance = transparentAppearence
	}
	
	var body: some View {
		TabView {
			List {
				ForEach(1...40, id: \.self) { eachRowIndex in
					Text("Row \(eachRowIndex)")
				}
			}
			.listStyle(.plain)
			.tabItem {
				Image(systemName: "house.fill")
				Text("Home")
			}
		}
	}
}
