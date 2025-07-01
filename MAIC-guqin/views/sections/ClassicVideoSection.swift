//
// ClassicVideoSection.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/27.
//

import SwiftUI

struct ClassicVideoSection: View {
    let sectionTitle: String?
    let showMoreButton: Bool
    
    @ObservedObject var viewModel: ClassicVideoViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Section 标题和“更多”按钮
            HStack {
                if let title = sectionTitle {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("TextPrimary"))
                }
                Spacer()
                if showMoreButton {
                    Button(action: {
                        print("更多 \(sectionTitle ?? "内容")")
                        // 未来可以导航到经典影像的更多列表页
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .foregroundColor(Color("TextPrimary"))
                    }
                }
            }
            .padding(.horizontal)

            // 经典影像列表，横向滚动
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 15) {
                    // 遍历 ViewModel 中的所有 PerformanceItem
                    ForEach(viewModel.performanceItems) { item in
                        // 将 ClassicVideoCard 包装在 NavigationLink 中，以便点击后跳转到详情页
                        NavigationLink(destination: PerformanceDetailView(item:item)) {
                            ClassicVideoCard(item: item)
                        }
                        .buttonStyle(CardPressEffectStyle()) // 使用自定义的style
                    }
                }
                .padding(.horizontal) // 为所有卡片及其容器添加水平内边距
            }
            // ClassicVideoCard 高度是 300，加上间距，这里设置 310
            .frame(height: 310)
        }
        .padding(.vertical, 5)
    }
}

struct ClassicVideoSection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: ClassicVideoViewModel = {
            let vm = ClassicVideoViewModel()
            vm.performanceItems = [
                PerformanceItem(
                    title: "春风",
                    performer: "赵家珍",
                    eventName: "中央民族乐团古琴之夜",
                    location: "深圳",
                    date: PerformanceItem.dateFormatter.date(from: "2024.10.27"),
                    coverImage: "经典影像", // 请确保你在 Assets 中有这张图
                    videoURL: nil,
                    description: "赵家珍老师的精彩演奏。"
                ),
                PerformanceItem(
                    title: "阳关三叠",
                    performer: "李祥霆",
                    eventName: "李祥霆古琴音乐会",
                    location: "北京",
                    date: PerformanceItem.dateFormatter.date(from: "2023.09.10"),
                    coverImage: "经典影像", 
                    videoURL: nil,
                    description: "李祥霆教授的古琴名曲《阳关三叠》。"
                ),
                PerformanceItem(
                    title: "平沙落雁",
                    performer: "吴兆基",
                    eventName: nil,
                    location: "上海",
                    date: PerformanceItem.dateFormatter.date(from: "1980.01.01"),
                    coverImage: "经典影像", // 请确保你在 Assets 中有这张图
                    videoURL: nil,
                    description: "吴兆基大师传世经典《平沙落雁》。"
                )
            ]
            return vm
        }()

        NavigationStack {
            VStack {
                ClassicVideoSection(sectionTitle: "经典影像", showMoreButton: true, viewModel: viewModel)
                    .frame(width: 380)
                    .background(Color("BackgroundPrimary"))
            }
        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Classic Video Section (Adapted)")
    }
}
