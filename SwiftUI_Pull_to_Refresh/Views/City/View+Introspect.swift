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
