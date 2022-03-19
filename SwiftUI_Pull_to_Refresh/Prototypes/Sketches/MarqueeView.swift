//
//  MarqueeView.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 2020. 07. 25.
//

import SwiftUI

struct MarqueeView: View {
    
    struct Metrics {
        
        static let iconCount = CGFloat(10)
        static let marqueeIconCount = CGFloat(3)
        
        static let iconSize = CGFloat(95)
        static let cornerRadius = CGFloat(20)
        static let spacing = CGFloat(15)
        
        static let duration = iconCount * 1
        static let marqueeWidth = iconSize * marqueeIconCount + spacing * (marqueeIconCount - 1)
        static let iconsWidth = iconSize * iconCount + spacing * (iconCount - 1)
        static let remainder = (iconsWidth - marqueeWidth) / 2
    }
    
    @State var offset = Metrics.remainder
    
    var body: some View {
        VStack {
            HStack {
                Text("test title here")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }
            HStack(spacing: Metrics.spacing) {
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .fill(.red)
                    .frame(width: Metrics.iconSize, height: Metrics.iconSize)
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .fill(.orange)
                    .frame(width: Metrics.iconSize, height: Metrics.iconSize)
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .fill(.yellow)
                    .frame(width: Metrics.iconSize, height: Metrics.iconSize)
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .fill(.green)
                    .frame(width: Metrics.iconSize, height: Metrics.iconSize)
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .fill(.cyan)
                    .frame(width: Metrics.iconSize, height: Metrics.iconSize)
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .fill(.blue)
                    .frame(width: Metrics.iconSize, height: Metrics.iconSize)
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .fill(.purple)
                    .frame(width: Metrics.iconSize, height: Metrics.iconSize)
                // Repeat last three icon (same as `marqueeIconCount`).
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .fill(.red)
                    .frame(width: Metrics.iconSize, height: Metrics.iconSize)
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .fill(.orange)
                    .frame(width: Metrics.iconSize, height: Metrics.iconSize)
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .fill(.yellow)
                    .frame(width: Metrics.iconSize, height: Metrics.iconSize)
            }
            .offset(x: offset, y: 0)
            .onAppear {
                withAnimation(Animation.linear(duration: Metrics.duration).repeatForever(autoreverses: false)) {
                    offset = -Metrics.remainder
                }
            }
        }
        .frame(width: Metrics.marqueeWidth)
        .background(.gray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
