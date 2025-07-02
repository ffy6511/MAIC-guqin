//
//  CalligraphyTextStyle.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/2.
//

import SwiftUI
// 毛笔字效果
struct CalligraphyTextStyle: ViewModifier {
    let fontSize: CGFloat
    let shadowOffset: CGSize
    let blurRadius: CGFloat
    
    init(fontSize: CGFloat = 15, shadowOffset: CGSize = CGSize(width: 1, height: 1), blurRadius: CGFloat = 1) {
        self.fontSize = fontSize
        self.shadowOffset = shadowOffset
        self.blurRadius = blurRadius
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom("STKaiti", size: fontSize))
            .fontWeight(.medium)
            .foregroundColor(.black)
            .background(
                content
                    .font(.custom("STKaiti", size: fontSize))
                    .fontWeight(.medium)
                    .foregroundColor(.gray.opacity(0.3))
                    .blur(radius: blurRadius)
                    .offset(shadowOffset)
            )
    }
}

extension View {
    func calligraphyStyle(fontSize: CGFloat = 15, shadowOffset: CGSize = CGSize(width: 1, height: 1), blurRadius: CGFloat = 1) -> some View {
        modifier(CalligraphyTextStyle(fontSize: fontSize, shadowOffset: shadowOffset, blurRadius: blurRadius))
    }
}
