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
                .padding(.vertical, 8)
                .padding(.horizontal, 5)
                .background(Color("BackgroundTertiary")) // 搜索框输入区域背景
                .cornerRadius(8)
                .foregroundColor(Color("TextPrimary")) // 输入文本颜色
        }
        .padding()
        .background(Color("BackgroundPrimary")) // 搜索栏的背景色
        .cornerRadius(15)
        .padding(.horizontal)
    }
}
