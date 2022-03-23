//
//  View+Introspect.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 22/03/2022.
//

import SwiftUI
import Introspect


extension View {
	
	public func introspectTableViewHeaderFooterView(customize: @escaping (UITableViewHeaderFooterView) -> Void) -> some View {
		introspect(selector: TargetViewSelector.ancestorOrSiblingContaining, customize: customize)
	}
}


extension View {
	
	func redLine(opacity: CGFloat = 1.0) -> some View {
		self
//			.background(Color.red.opacity(0.2 * opacity))
//			.border(Color.red.opacity(opacity), width: 1)
	}
}
