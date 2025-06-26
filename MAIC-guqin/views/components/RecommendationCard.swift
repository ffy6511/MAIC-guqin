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
        // 最外层使用 ZStack 来实现图片背景和文字叠加的效果
        ZStack(alignment: .topLeading) {

            // ---------- 背景图片部分 ----------
            // 根据 item.imageName 是否能加载到图片来决定显示内容
            if let uiImage = UIImage(named: item.imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 258, height: 160)
                    .clipped()
                    .opacity(0.6)
            } else {
                // 如果图片不存在，显示默认的占位图
                Image("推荐图片")
                    .resizable()
                    .scaledToFill() // 占位图也填充整个区域
                    .frame(width: 258, height: 160)
                    .background(Color.gray.opacity(0.4)) // 占位图的背景色，使其可见
                    .opacity(0.6)
            }

            // ---------- 渐变蒙版（如果需要）----------
            // 观察Figma图，文字下方似乎有一个从透明到深色的渐变区域
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.6)]),
                           startPoint: .leading, // 渐变从中间开始
                           endPoint: .trailing) // 渐变到底部
                .frame(width: 258, height: 160)

            // ---------- 文字信息部分 ----------
            VStack(alignment: .leading, spacing: 4) { // 文字内容VStack，文字行间距
                Text(item.title)
                    .font(.title3) // 标题字体可能更大
                    .fontWeight(.bold) // 标题字重加粗
                    .lineLimit(2) // 允许两行标题
                    .foregroundColor(.textInversePrimary)

                Text(item.subtitle)
                    .font(.body)
                    .foregroundColor(.textInverseSecondary)
                    .lineLimit(1)

                Text(item.date)
                    .font(.caption)
                    .foregroundColor(.textInverseSecondary)

            }
            .padding()
            
            // ---------- 右下角的 'item.plays' 部分 ----------
                       // 这是一个独立的 Text 视图，直接在 ZStack 中使用 .alignment 修饰符
           Text(item.plays)
               .font(.caption)
               .foregroundColor(.textInverseSecondary)
               .padding()
               .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
//            将文字的逻辑边界扩展到与父视图一样大，然后将其通过alignment对齐到右下角

            

        }
        // ---------- 整个卡片的样式 ----------
        .frame(width: 258, height: 160)
        .background(Color.black.opacity(0.1)) // 确保背景色透明度，让图片显示
        .cornerRadius(16) // 整个卡片的圆角
        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4) // 阴影更明显

    }
}

// Preview for RecommendationCard
struct RecommendationCard_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationCard(item: RecommendationItem(
            imageName: "recommendation_image1", // 确保这个图片在 Assets 中，并且这张图是那张大图的背景图
            title: "苏思思-《潇湘水云》",
            subtitle: "中央民族乐团古筝之夜",
            date: "2024.10.27 深圳", // 这个日期在Figma图里是和城市一起的
            plays: "跟练过该曲目8次" // 播放次数是“跟练过该曲目8次”
        ))
        .previewLayout(.sizeThatFits) // 预览时自动调整大小以适应内容
        .padding() // 给预览卡片一个外边距，使其不贴边
    }
}
