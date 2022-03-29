//
//  ViewModel.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 14/03/2022.
//

import Foundation


class ViewModel: ObservableObject {
	
	func fetch(_ completion: @escaping () -> Void) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion()
		}
	}
	
	func fetch() async {
		await withCheckedContinuation { continuation in
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				continuation.resume()
			}
		}
	}
}
