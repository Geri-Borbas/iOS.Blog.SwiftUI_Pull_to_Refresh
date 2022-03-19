//
//  HeaderView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/03/2022.
//

import SwiftUI


struct HeaderView: View {
	
	init() {
		UITableViewHeaderFooterView.appearance().backgroundView = UIView()
	}
	
	var body: some View {
		ZStack {
			Image("Map")
				.opacity(0.5)
			List {
				Section(
					header: VStack {
						Text("Section 1")
							.font(.system(size: 40))
							.frame(height: 60)
					},
					content: {
						ForEach(1...20, id: \.self) { eachRowIndex in
							Text("Row \(eachRowIndex)")
								.listRowBackground(Color.clear)
						}
					}
				)
			}
			.listStyle(.plain)
			.padding(.top, 40)
		}
	}
}
