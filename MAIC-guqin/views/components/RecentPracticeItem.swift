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
        HStack(alignment: .center, spacing: 12) { // 最外层 Hstack，垂直居中对齐所有子视图，保持间距

            // ---------- 左侧：图片部分 ----------
            // 使用 GeometryReader 辅助图片高度与右侧内容总高对齐（如果需要，但通常 Hstack.alignment: .center 配合固定 frame 就够了）
            // 更直接的方法是确保图片和右侧内容都由外部统一的框架约束
            if let uiImage = UIImage(named: item.imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill() // 确保图片填充其设定的 frame
                    .frame(width: 90, height: 90)
                    .clipped() // 裁剪超出部分
                    .cornerRadius(8) // 图片圆角
            } else {
                // 如果图片不存在，显示默认的占位图
                Image("近期练习") // SF Symbol 图标
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90) // 占位图尺寸与实际图片一致
                    .foregroundColor(.gray) // 占位图图标颜色
                    .background(Color.white.opacity(0.8)) // 占位图背景色，使其在背景上可见
                    .cornerRadius(8)
            }

            // ---------- 右侧：包含文本、进度条和播放按钮的 VStack ----------
            VStack(alignment: .center, spacing: 8) { // 垂直堆叠：文本行、进度条、播放控制
                // 1. 标题和进度文本行
                HStack(spacing: 8) {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color("TextPrimary"))

                    Text(item.progress)
                        .font(.caption)
                        .foregroundColor(Color("TextSecondary"))
                }

                // 2. 进度条
                ProgressView(value: item.progressValue)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color("AccentColor"))) // 恢复 AccentColor
                    .frame(height: 5)
                    .clipShape(Capsule())
                    // 确保没有多余的 padding
                
                
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image(systemName: "arrow.counterclockwise") // 循环图标
                            .font(.body) // 调整大小
                            .foregroundColor(Color("TextSecondary")) // 恢复 TextSecondary 颜色
                    }
                    Button(action: {}) {
                        Image(systemName: "backward.fill") // 上一曲图标
                            .font(.title3) // 调整大小
                            .foregroundColor(Color("TextSecondary")) // 恢复 TextSecondary 颜色
                    }
                    Button(action: {}) {
                        Image(systemName: "play.fill") // Figma 图中是实心三角形，play.fill 更合适
                            .font(.title2) // 大小略小于 largeTitle，但比其他按钮大，作为核心
                            .foregroundColor(Color("TextSecondary")) // 恢复 AccentColor 颜色
                    }
                    Button(action: {}) {
                        Image(systemName: "forward.fill") // 下一曲图标
                            .font(.title3) // 调整大小
                            .foregroundColor(Color("TextSecondary")) // 恢复 TextSecondary 颜色
                    }
                    Button(action: {}) {
                        Image(systemName: "list.bullet") // 菜单图标
                            .font(.body) // 调整大小
                            .foregroundColor(Color("TextSecondary")) // 恢复 TextSecondary 颜色
                    }
                }
                
            }

            Spacer() // 将中间的 VStack 和最右侧的播放控制按钮组推开

            
        }
        .background(Color("BrandSecondary").opacity(0.3)) // 恢复你原始代码的背景色及透明度
        .cornerRadius(10) // 卡片整体圆角
        .shadow(radius: 3)
    }
}


// Preview for RecentPracticeItem
struct RecentPracticeItem_Previews: PreviewProvider {
    static var previews: some View {
        Group { // 使用 Group 来包含多个预览
            // 正常显示图片的预览
            RecentPracticeItem(item: PracticeItem(
                imageName: "推荐图片", // 确保这个图片在 Assets 中
                title: "《潇湘水云》",
                progress: "已练习8次", // 匹配Figma文本
                progressValue: 0.7 // 示例进度值
            ))
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("正常图片") // 预览名称

            // 图片不存在时的预览 (将显示 SF Symbol 的 "photo" 图标)
            RecentPracticeItem(item: PracticeItem(
                imageName: "non_existent_practice_image", // 这个图片在 Assets 中不存在
                title: "《不存在的曲目》",
                progress: "未开始练习",
                progressValue: 0.0 // 示例进度值
            ))
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("缺失图片") // 预览名称
        }
    }
}
