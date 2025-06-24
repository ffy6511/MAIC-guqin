//
//  RecentPracticeItem.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import SwiftUI

struct RecentPracticeItem: View {
    let item: PracticeItem // 直接接收一个 Model 实例

    var body: some View {
        HStack {
            Image(item.imageName) // 确保 Assets 中有这些图片
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color("TextPrimary"))
                Text(item.progress)
                    .font(.caption)
                    .foregroundColor(Color("TextSecondary"))
            }

            Spacer()

            // 播放/暂停按钮组
            HStack(spacing: 15) {
                Button(action: {}) {
                    Image(systemName: "backward.fill")
                        .font(.title2)
                        .foregroundColor(Color("TextSecondary"))
                }
                Button(action: {}) {
                    Image(systemName: "play.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color("AccentColor")) // 假设播放按钮颜色
                }
                Button(action: {}) {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                        .foregroundColor(Color("TextSecondary"))
                }
            }
        }
        .padding(.vertical, 8)
        .background(Color("BackgroundSecondary"))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
