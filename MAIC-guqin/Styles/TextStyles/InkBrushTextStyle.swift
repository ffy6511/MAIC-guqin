//
//  InkBrushTextStyle.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/2.
//

import SwiftUI

// 水墨风格文字效果
struct InkBrushTextStyle: ViewModifier {
    let fontSize: CGFloat
    let fontName: String
    
    init(fontSize: CGFloat = 14, fontName: String = "STKaiti") {
        self.fontSize = fontSize
        self.fontName = fontName
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: fontSize))
            .foregroundStyle(
                LinearGradient(
                    colors: [.black, .gray.opacity(0.7)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .shadow(color: .black.opacity(0.3), radius: 1, x: 1, y: 1)
    }
}

extension View {
    func inkBrushStyle(fontSize: CGFloat = 14, fontName: String = "STKaiti") -> some View {
        modifier(InkBrushTextStyle(fontSize: fontSize, fontName: fontName))
    }
}
