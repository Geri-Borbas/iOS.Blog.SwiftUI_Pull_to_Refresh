//
//  Network.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/09/2021.
//

import Foundation


struct Network {
	
	
	static func refresh(completion: @escaping () -> Void) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			completion()
		}
	}
}
