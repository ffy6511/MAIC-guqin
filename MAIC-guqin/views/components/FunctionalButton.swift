//
//  FunctionalButton.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//


import SwiftUI

struct FunctionalButton: View {
    let title: String
    let icon: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(Color("AccentColor")) // 使用 Assets 颜色
                .padding(10)
                .background(Color("BackgroundSecondary")) // 使用 Assets 颜色
                .clipShape(Circle())
                .shadow(radius: 3)
            Text(title)
                .font(.caption)
                .foregroundColor(Color("TextPrimary"))
        }
    }
}
