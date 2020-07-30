//
//  RefreshControl.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 30..
//

import SwiftUI
import Combine

class RefreshControl: ObservableObject {
    
    @Published var scrollView: UIScrollView?
    private var subscribers: Set<AnyCancellable> = []
    
    init() {
        $scrollView
            .compactMap { $0 }
            .removeDuplicates()
            .sink { (scrollView: UIScrollView) in
            print("RefreshControl.scrollView: \(scrollView)")
        }.store(in: &subscribers)
    }
}
