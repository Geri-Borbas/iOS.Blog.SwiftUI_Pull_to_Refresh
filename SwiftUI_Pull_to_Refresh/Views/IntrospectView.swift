//
//  IntrospectView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 12/03/2022.
//

import SwiftUI
import Introspect

struct IntrospectView: View {
	
	let size = CGSize(width: 375, height: 800)
	let colors: [UIColor] = [
		.red,
		.orange,
		.yellow,
		.green,
		.cyan,
		.blue,
		.purple,
		.red,
		.orange,
		.yellow,
		.green,
		.cyan,
		.blue,
		.purple,
		.red,
		.orange,
		.yellow,
		.green,
		.cyan,
		.blue,
		.purple,
		.red,
		.orange,
		.yellow
	]
	
	var body: some View {
		ScrollView(.horizontal) {
			HStack(spacing: 0) {
				ForEach(0..<20) { horizontalIndex in
					VStack {
						Text("Header \(horizontalIndex + 1)")
						List(0..<20) { verticalIndex in
							Text("\(horizontalIndex + 1) : \(verticalIndex + 1)")
						}
						.padding(.vertical)
						.introspectTableView { view in
							view.backgroundColor = colors[horizontalIndex]
						}
					}
					.background(Color.gray)
					.padding(.vertical)
					.frame(width: size.width, height: size.height)
				}
				
			}
		}
		.introspectScrollView { scrollView in
			scrollView.isPagingEnabled = true
			scrollView.backgroundColor = .black
		}
		.padding(.vertical)
	}
}
