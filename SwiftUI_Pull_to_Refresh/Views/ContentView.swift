//
//  ContentView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 29..
//

import SwiftUI

struct ContentView: View {
    
    @State var scrollView: UIScrollView?
    let refreshControl: RefreshControl = RefreshControl()
    
    var body: some View {
        
        List {
            ScrollViewResolver(refreshControl: refreshControl).background(Color(.gray))
            ForEach(1...100, id: \.self) { eachRowIndex in
                Text("Row \(eachRowIndex)")
            }
        }
    }
}
