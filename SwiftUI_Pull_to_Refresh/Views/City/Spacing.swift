//
//  Spacing.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 19/03/2022.
//

import SwiftUI


struct Spacing: View {

	let minLength: CGFloat?

	init(_ minLength: CGFloat? = nil) {
		self.minLength = minLength
	}

	var body: some View {
		Spacer(minLength: minLength)
	}
}
