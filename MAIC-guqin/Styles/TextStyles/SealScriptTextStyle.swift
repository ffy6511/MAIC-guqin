//
//  SealScriptTextStyle.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/9.
//

import SwiftUI

struct SealScriptTextStyle: ViewModifier{
    let fontSize: CGFloat
    let color: Color
    
    func body(content: Content) -> some View{
        content
            .font(.custom("三极秦韵小篆" , size: fontSize))
            .foregroundColor(color)
    }
}

extension View{
    func SealScriptStyle(fontSize: CGFloat, color: Color = .white) -> some View{
        self.modifier(SealScriptTextStyle(fontSize: fontSize, color: color))
    }
}

