//
// ScoreItemCard.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/26.
//

import SwiftUI

struct ScoreItemCard: View {
    let item: ScoreItem // 接收一个 ScoreItem 数据

    var body: some View {
        HStack(spacing: 12) { // 使用 HStack，图片在左，文字在右
            // 左侧图片
            Image(item.image) // 从 ScoreItem 中获取图片名称
                .resizable()
                .aspectRatio(contentMode: .fill) // 图片填充模式
                .frame(width: 90, height: 90) // 固定图片尺寸
                .clipped() // 裁剪超出部分
                .cornerRadius(8) // 图片圆角
                .shadow(radius: 3)

            // 右侧文字内容
            VStack(alignment: .leading, spacing: 8) { // 文字内容垂直排列
                
                HStack{
                    Text(item.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color("TextPrimary")) // 确保颜色资源存在
                        .lineLimit(1) // 限制一行
                   
                    Spacer()
                    
                    // 作曲家
                    if let composer = item.composer {
                        Text(composer)
                            .font(.caption)
                            .foregroundColor(Color("TextSecondary"))
                            .lineLimit(1)
                            .padding(.horizontal)
                    }
                    
                }
                
                // 标签
                HStack(spacing: 4) {
                    ForEach(item.tags, id: \.self) { tag in // 遍历标签
                        Text(tag)
                            .font(.caption2)
                            .foregroundColor(Color("TextSecondary")) // 确保颜色资源存在
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color("BackgroundTertiary")) // 标签背景色
                            .cornerRadius(5)
                    }
                }



                // 跟练人数及播放图标
                HStack {
                    Text("\(item.practiceCount)人已跟练")
                        .font(.caption)
                        .foregroundColor(Color("TextTertiary")) // 确保颜色资源存在

                    Spacer() // 将播放图标推到右侧

                    // 只有当 musicXMLURL 存在时才显示播放图标
                    if item.musicXMLURL != nil {
                        Image(systemName: "play.circle.fill") // 播放图标
                            .font(.caption) // 匹配字体大小
                            .foregroundColor(Color("BrandPrimary")) // 使用主品牌色或其他适合的颜色
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) // 确保文字 VStack 占据剩余所有宽度并左对齐
        }
        .padding(0) // 整体卡片内边距
        .background(Color("BrandSecondary").opacity(0.5))
        .cornerRadius(12) // 卡片圆角
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3) // 卡片阴影
    }
}

struct ScoreItemCard_Previews: PreviewProvider {
    static var previews: some View {
        // 示例数据，包含 pdfURL 和 musicXMLURL
        let sampleItem = ScoreItem(
            title: "《广陵散》",
            image: "曲谱",
            tags: ["十大古琴名曲", "古琴考级十级曲目"],
            practiceCount: 11364,
            composer: "嵇康",
            duration: 600,
            difficulty: "高级",
            description: "《广陵散》是中国十大古琴名曲之一，旋律激昂慷慨。",
            pdfURL: ScoreItem.localURL(for: "styx", fileExtension: "pdf"),
            musicXMLURL: nil,
            midiURL: nil
        )


        Group { // 使用 Group 来显示多个预览
            ScoreItemCard(item: sampleItem)
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Score Card with MusicXML")

        }
    }
}
