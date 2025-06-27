//
// PerformanceDetailView.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/27.
//

import SwiftUI
import AVKit // 引入 AVKit 框架用于视频播放

struct PerformanceDetailView: View {
    let item: PerformanceItem // 接收一个 PerformanceItem 数据

    var body: some View {
        ScrollView { // 使用 ScrollView 确保内容可滚动
            VStack(alignment: .leading, spacing: 20) {
                // 1. 视频播放器或占位符
                if let videoURL = item.videoURL {
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(height: 250) // 视频播放器的高度
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal) // 视频播放器左右内边距
                } else {
                    // 如果没有视频URL，显示一个占位符图片和文本
                    Image(item.coverImage) // 使用封面图作为占位背景
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(10)
                        .overlay(
                            Text("视频资源暂不可用")
                                .font(.title3)
                                .foregroundColor(.white)
                                .shadow(radius: 3)
                        )
                        .padding(.horizontal)
                }

                // 2. 标题和作者
                HStack(spacing: 5) {
                    Text(item.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("TextPrimary"))

                    Spacer()
                    
                    Text("演奏者: \(item.performer)")
                        .font(.title2)
                        .foregroundColor(Color("TextSecondary"))
                        .padding()
                }
                .padding(.horizontal)

                // 3. 其他详细信息
                VStack(alignment: .leading, spacing: 8) {
                    if let eventName = item.eventName {
                        HStack {
                            Image(systemName: "music.mic")
                                .foregroundColor(Color("AccentColor"))
                            Text("活动: ")
                           + Text(eventName)
                               .font(.headline)
                               .fontWeight(.medium)
                               .foregroundColor(Color("TextPrimary"))
                        }
                    }
                    if let location = item.location {
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(Color("AccentColor"))
                            Text("地点: ")
                            + Text(location)
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(Color("TextPrimary"))
                        }
                    }
                    if let date = item.date {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(Color("AccentColor"))
                            Text("时间: ")
                            + Text(PerformanceItem.dateFormatter.string(from: date))
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(Color("TextPrimary"))
                        }
                    }
                }
                .font(.body)
                .foregroundColor(Color("TextSecondary"))
                .padding(.horizontal, 16)

                // 4. 描述
                if let description = item.description, !description.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("简介")
                            .font(.headline)
                            .foregroundColor(Color("TextPrimary"))
                        Text(description)
                            .font(.body)
                            .foregroundColor(Color("TextPrimary"))
                            .lineSpacing(5) // 行间距
                            .padding(.horizontal, 8)
                    }
                    .padding(.horizontal)
                    .padding(.top, 4)
                }
                
                Spacer() // 将内容推到顶部
            }
            .padding(.top) // 顶部内边距
        }
        .navigationTitle(item.title) // 设置导航栏标题为曲名
        .navigationBarTitleDisplayMode(.inline) // 标题显示模式为小标题
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(hex: "#9BB1A8").opacity(0.75), location: 0),
                    .init(color: Color(hex: "#FFFFFF").opacity(0.75), location: 0.21),
                    .init(color: Color(hex: "#EDF1EF").opacity(0.75), location: 0.80),
                    .init(color: Color(hex: "#9BB1A8").opacity(0.75), location: 0.96)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea() // 让渐变色扩展到安全区域之外，包括导航栏背后
        ) // 确保背景色填充整个屏幕
    }
}

struct PerformanceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // 创建一个示例 PerformanceItem 用于预览
        let sampleItem = PerformanceItem(
            title: "广陵散",
            performer: "赵家珍",
            eventName: "中央民族乐团古琴之夜",
            location: "深圳",
            date: PerformanceItem.dateFormatter.date(from: "2024.10.27"),
            coverImage: "经典影像", // 使用你统一的图片资源
            videoURL: nil, // 这里设置为 nil，模拟暂时没有视频的情况
            description: "《广陵散》是一首著名的古琴曲，是中国古代十大名曲之一，表现了聂政刺韩王为父报仇的故事，充满了慷慨激昂、悲愤苍凉的复仇情绪。"
        )
        
        let sampleItemWithVideo = PerformanceItem(
            title: "阳关三叠",
            performer: "李祥霆",
            eventName: "李祥霆古琴音乐会",
            location: "北京",
            date: PerformanceItem.dateFormatter.date(from: "2023.09.10"),
            coverImage: "经典影像", // 使用你统一的图片资源
            videoURL: PerformanceItem.localURL(for: "sample_video", fileExtension: "mp4"), // 假设有一个名为 "sample_video.mp4" 的本地视频文件
            description: "《阳关三叠》是根据唐代诗人王维的七绝《送元二使安西》谱写的一首琴歌，表达了深厚的离别之情和对友人的美好祝愿。这首曲子旋律优美，意境深远，是古琴曲中的经典代表作。"
        )


        NavigationStack { // 预览时需要 NavigationStack 来模拟导航环境
            PerformanceDetailView(item: sampleItem)
        }
        .previewDisplayName("Performance Detail View (No Video)")

        NavigationStack {
            PerformanceDetailView(item: sampleItemWithVideo)
        }
        .previewDisplayName("Performance Detail View (With Video)")
    }
}
