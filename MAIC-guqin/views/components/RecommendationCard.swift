//
//  RecommendationCard.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import SwiftUI

struct RecommendationCard: View {
    let item: RecommendationItem // 直接接收一个 Model 实例

    var body: some View {
        VStack(alignment: .leading) {
            Image(item.imageName) // 确保 Assets 中有这些图片
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 100)
                .clipped()
                .cornerRadius(8)

            Text(item.title)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
                .foregroundColor(Color("TextPrimary"))
            Text(item.subtitle)
                .font(.caption)
                .foregroundColor(Color("TextSecondary"))
                .lineLimit(1)
            Text(item.date)
                .font(.caption2)
                .foregroundColor(Color("TextTertiary"))
            Text(item.plays)
                .font(.caption2)
                .foregroundColor(Color("TextTertiary"))
        }
        .frame(width: 150)
        .padding(10)
        .background(Color("BackgroundSecondary"))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
