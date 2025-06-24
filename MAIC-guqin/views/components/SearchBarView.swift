//
//  SearchBarView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import SwiftUI

struct SearchBarView: View {
    @State private var searchText: String = ""

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("TextSecondary"))
            TextField("高山流水大师现场演奏视频", text: $searchText)
                .foregroundColor(Color("TextPrimary")) // 输入文本颜色
                
        }
        .padding()
        .background(
            Color("BackgroundPrimary")
                .opacity(0.5)
                .background(
                    BlurView(style: .systemUltraThinMaterial)
                )
                .cornerRadius(20)
        )
        .padding(.horizontal)
    }
}

struct BlurView: UIViewRepresentable{
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> some UIView {
        return UIVisualEffectView(effect: UIBlurEffect(style:style))
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
