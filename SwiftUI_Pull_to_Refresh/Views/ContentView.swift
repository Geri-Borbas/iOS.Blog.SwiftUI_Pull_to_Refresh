//
//  ContentView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI

struct ContentView: View {
    
    @State var viewController: UIViewController?
    @State var scrollView: UIScrollView?
    
    @ViewBuilder
    var body: some View {
        
        ViewControllerResolver(onResolve: { viewController in
            self.viewController = viewController
        })
        
        List {
            ScrollViewResolver(
                viewController: $viewController,
                scrollView: $scrollView
            ).background(Color(.gray))
            ForEach(1...100, id: \.self) { eachRowIndex in
                Text("Row \(eachRowIndex)")
            }
        }
    }
}
