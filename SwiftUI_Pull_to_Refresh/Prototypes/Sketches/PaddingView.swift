//
//  PaddingView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/03/2022.
//

import SwiftUI
import Introspect


struct PaddingView: View {
    
    init() {
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundView = UIView()
        UITableViewHeaderFooterView.appearance().backgroundView = UIView() // iOS 14+
    }
    
    var body: some View {
        ZStack {
            Grid().opacity(0.1)
            VStack {
                Spacer(minLength: 60)
                List {
                    Section(
                        header: HStack {
                            Text("Section Heaeder").font(.system(size: 40))
                            Spacer()
                        }
                            .frame(height: 60)
                            .background(Grid().opacity(0.2))
                            .listRowInsets(.zero)
                            .listRowBackground(Color.clear)
                            .introspectTableViewHeaderFooterView {
                                $0.backgroundView = UIView() // For iOS 13
                            },
                        
                        content: {
                            ForEach(1...20, id: \.self) { eachRowIndex in
                                Text("Row \(eachRowIndex)")
                                    .frame(height: 40)
                                    .listRowInsets(.zero)
                                    .listRowBackground(
                                        Rectangle()
                                            .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
                                    )
                            }
                        }
                    )
                }
                .listStyle(.plain)
                .introspectTableView {
                    $0.separatorStyle = .none
                }
                .background(Grid().opacity(0.1))
                .padding(.leading, 20)
                .padding(.trailing, 25)
                .environment(\.defaultMinListRowHeight, 40)
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

extension EdgeInsets {
    
    static var zero = EdgeInsets()
}


struct Grid: View {
    
    var body: some View {
        Rectangle()
            .fill(
                ImagePaint(image: Image("10pt"))
            )
    }
}


extension View {
    
    public func introspectTableViewHeaderFooterView(customize: @escaping (UITableViewHeaderFooterView) -> Void) -> some View {
        introspect(selector: TargetViewSelector.ancestorOrSiblingContaining, customize: customize)
    }
}
