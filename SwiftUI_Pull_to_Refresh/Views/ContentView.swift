//
//  ContentView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI

struct ContentView: View {
    
    let refreshControl: RefreshControl = RefreshControl()
    
    var body: some View {    
        List {
            ScrollViewResolver(for: refreshControl)
            ForEach(1...100, id: \.self) { eachRowIndex in
                Text("Row \(eachRowIndex)")
            }
        }
    }
}
