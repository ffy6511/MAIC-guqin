//
//  SignatureTextStyle.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/2.
//

import SwiftUI

struct SignatureTextStyle: ViewModifier {
    let showBackground: Bool
    let animationEnabled: Bool
    
    init(showBackground: Bool = true, animationEnabled: Bool = false) {
        self.showBackground = showBackground
        self.animationEnabled = animationEnabled
    }
    
    func body(content: Content) -> some View {
        let styledContent = content
            .inkBrushStyle(fontSize: 16)
        
        if animationEnabled {
            styledContent
                .scaleEffect(1.0 + sin(Date().timeIntervalSince1970) * 0.05)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: Date().timeIntervalSince1970)
                .conditionalBackground(showBackground: showBackground)
        } else {
            styledContent
                .conditionalBackground(showBackground: showBackground)
        }
    }
}

extension View {
    func signatureStyle(showBackground: Bool = true, animationEnabled: Bool = false) -> some View {
        modifier(SignatureTextStyle(showBackground: showBackground, animationEnabled: animationEnabled))
    }
    
    @ViewBuilder
    func conditionalBackground(showBackground: Bool) -> some View {
        if showBackground {
            self
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.ultraThinMaterial)
                        .opacity(0.3)
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                )
        } else {
            self
        }
    }
}
