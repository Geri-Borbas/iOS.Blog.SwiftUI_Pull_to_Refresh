//
//  Network.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 14/03/2022.
//

import Foundation


struct Network {
	
	static func load(_ completion: @escaping () -> Void) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
	
	static func load() async {
		await withCheckedContinuation { continuation in
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				continuation.resume()
			}
		}
	}
}
