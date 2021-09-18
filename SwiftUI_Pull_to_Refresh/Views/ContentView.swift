//
//  ContentView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI


struct ContentView: View {
	
	var body: some View {
		VStack {
			HStack {
				List {
					ForEach(1...100, id: \.self) { eachRowIndex in
						Text("Left \(eachRowIndex)")
					}
				}
				.refreshControl { refreshControl in
					Network.refresh {
						refreshControl.endRefreshing()
					}
				}
				List {
					ForEach(1...100, id: \.self) { eachRowIndex in
						Text("Right \(eachRowIndex)")
					}
				}
				.refreshControl { refreshControl in
					Network.refresh {
						refreshControl.endRefreshing()
					}
				}
			}
		}
	}
}
