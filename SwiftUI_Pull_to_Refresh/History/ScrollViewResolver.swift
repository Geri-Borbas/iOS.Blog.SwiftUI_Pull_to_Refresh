//
//  ScrollViewResolver.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI

protocol ScrollViewConsumer: AnyObject {
	
    var scrollView: UIScrollView? { get set }
}

struct ScrollViewResolver<ConsumerType: ScrollViewConsumer>: UIViewRepresentable {
    
    let consumer: ConsumerType
    
    init(for consumer: ConsumerType) {
        self.consumer = consumer
    }
    
    func makeUIView(context: Context) -> UIView {
        print("ScrollViewResolver.makeUIView()")
        return UIView(frame: .zero).testable(as: "ScrollViewResolver")
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        print("ScrollViewResolver.updateUIView()")
        
        // Only if not resolved yet.
        if consumer.scrollView != nil {
            print("Already resolved scrollView.")
            return
        }
        
        // Lookup view ancestry for any `UIScrollView` then callback if any.
        if let scrollView = view.searchViewAnchestors(for: UIScrollView.self) {
            print("Resolved scrollView: \(scrollView)")
            consumer.scrollView = scrollView
        }
    }
}
