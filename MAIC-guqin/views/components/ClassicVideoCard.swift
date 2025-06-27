//
// ClassicVideoCard.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/27.
//

import SwiftUI

struct ClassicVideoCard: View {
    let item: PerformanceItem // 接收一个 PerformanceItem 数据

    var body: some View {
        // 整个卡片使用 ZStack 布局
        ZStack(alignment: .topLeading) {
            Image(item.coverImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 300)
                .clipped() // 裁剪超出部分
                .cornerRadius(12) // 卡片圆角，与截图一致
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5) // 卡片阴影
                .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(hex: "#FFFFFF"),
                                Color(hex: "#5E5E5E")
                            ]),
                            startPoint: .trailing,
                            endPoint: .leading
                        )
                        .cornerRadius(12)
                        .opacity(0.3) // 渐变蒙版透明度
                    )
                
            
            // 2. 文字信息 (左上角)
            VStack(alignment: .leading, spacing: 4) {
                // 作者 - 《曲名》
                Group {
                    Text(item.title)
                        .fontWeight(.bold)
                    Text(item.performer)
                }
                .font(.subheadline)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.5), radius: 2)

                
                // 活动名称
                if let eventName = item.eventName {
                    Text(eventName)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                        .shadow(color: .black.opacity(0.5), radius: 2)
                        .padding(.top, 8)
                }
                
                // 日期和地点
                HStack(spacing: 4) {
                    if let date = item.date {
                        Text(PerformanceItem.dateFormatter.string(from: date))
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                            .shadow(color: .black.opacity(0.5), radius: 2)
                    }
                    if item.date != nil && item.location != nil {
                        Text("•")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                            .shadow(color: .black.opacity(0.5), radius: 2)
                    }
                    if let location = item.location {
                        Text(location)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                            .shadow(color: .black.opacity(0.5), radius: 2)
                    }
                }
            }
            .padding(20) // 文字内容的内边距
            
            // 3. 播放按钮 (居中)
//            if item.videoURL != nil {
//                Image(systemName: "play.circle.fill")
//                    .font(.system(size: 80)) // 巨大的播放图标
//                    .foregroundColor(.white.opacity(0.8))
//                    .shadow(color: .black.opacity(0.5), radius: 5)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity) // 让播放按钮在 ZStack 中居中
//            }
            
            Image(systemName: "play.circle.fill")
               .font(.system(size: 60)) // 巨大的播放图标
               .foregroundColor(.white.opacity(0.6))
               .shadow(color: .black.opacity(0.5), radius: 5)
               .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            // 4. 心形收藏按钮
            VStack {
                Spacer()
                
                HStack {
                    Spacer() // 将心形推到右侧
                    Button(action: {
                        print("收藏按钮点击了：\(item.title)")
                        // 实现收藏逻辑
                    }) {
                        Image(systemName: "heart.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white.opacity(0.6))
                            .shadow(color: .black.opacity(0.5), radius: 3)
                            .padding(.trailing, 16) // 右边距
                            .padding(.bottom, 16) // 上边距
                    }
                }
                
            }

        }
        .frame(width: 200, height: 300)
    }
}

struct ClassicVideoCard_Previews: PreviewProvider {
    static var previews: some View {
        let sampleItem = PerformanceItem(
            title: "《广陵散》",
            performer: "赵家珍",
            eventName: "中央民族乐团古琴之夜",
            location: "深圳",
            date: PerformanceItem.dateFormatter.date(from: "2024.10.27"),
            coverImage: "经典影像", // 确保 Assets 中有此图片
            videoURL: nil, // 暂时空缺
            description: "赵家珍老师的精彩演奏。"
        )

        ClassicVideoCard(item: sampleItem)
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Classic Video Card")
    }
}
