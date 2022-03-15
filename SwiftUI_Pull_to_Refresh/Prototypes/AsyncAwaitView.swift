//
//  AsyncAwaitView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 15/03/2022.
//

import SwiftUI


struct AsyncAwaitView: View {
	
	var body: some View {
		List {
			ForEach(1...100, id: \.self) { eachRowIndex in
				Text("Row \(eachRowIndex)")
			}
		}
		.refreshable {
			await Network.load()
		}
	}
}
