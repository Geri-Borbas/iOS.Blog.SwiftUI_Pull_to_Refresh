//
//  ContentView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 25..
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var refreshControl_1: RefreshControl = RefreshControl()
    @ObservedObject var refreshControl_2: RefreshControl = RefreshControl()
    
    @ViewBuilder
    var body: some View {
        
        List {
            RefreshControlInjector(
                refreshControl: self.refreshControl_1,
                onValueChanged: {
                self.refresh_1()
            })
            ForEach(1...100, id: \.self) { eachRowIndex in
                Text("Row \(eachRowIndex)")
            }
                .opacity(self.refreshControl_1.isRefreshing ? 0.2 : 1.0)
        }
        
        List {
            RefreshControlInjector(
                refreshControl: self.refreshControl_2,
                onValueChanged: {
                self.refresh_2()
            })
            ForEach(1...100, id: \.self) { eachRowIndex in
                Text("Row \(eachRowIndex)")
            }
                .opacity(self.refreshControl_2.isRefreshing ? 0.2 : 1.0)
        }
    }
    
    func refresh_1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl_1.isRefreshing = false
        }
    }
    
    func refresh_2() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl_2.isRefreshing = false
        }
    }
}

struct RefreshControlInjector: View {
    
    var refreshControl: RefreshControl
    let onValueChanged: () -> Void
    
    var body: some View {
        ScrollViewResolver(onResolve: { (scrollView: UIScrollView) in
            self.refreshControl.add(to: scrollView)
            self.refreshControl.add(onValueChanged: onValueChanged)
        })
    }
}
