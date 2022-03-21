//
//  TitleView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct TitleView: View {
	
	let name: String
	let dateAndTimeString: String
	
	var body: some View {
		Text(name)
			.titleStyle()
		Text(dateAndTimeString)
			.regularStyle()
	}
}


extension TitleView {
	
	static let mock = TitleView(
		name: "San Jose",
		dateAndTimeString: "Tue Sept 22 at 13:15"
	)
}
