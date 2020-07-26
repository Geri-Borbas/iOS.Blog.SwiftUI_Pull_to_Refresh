//
//  ContentView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 25..
//

import SwiftUI


struct ContentView: View {
    
    @State var isRefreshing: Bool = false
    
    var body: some View {
        List {
            RefreshControl(isRefreshing: $isRefreshing) {
                self.refresh()
            }
            ForEach(1...100, id: \.self) { eachRowIndex in
                Text("Row \(eachRowIndex)")
            }
                .opacity(isRefreshing ? 0.2 : 1.0)
        }
            .onAppear {
                self.isRefreshing = true
                self.refresh()
            }
    }
    
    func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.isRefreshing = false
        }
    }
}
