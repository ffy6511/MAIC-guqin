//
// ClassicVideoViewModel.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/27.
//

import Foundation

class ClassicVideoViewModel: ObservableObject {
    @Published var performanceItems: [PerformanceItem]

    init() {
        // 暂时只硬编码一个 PerformanceItem 示例数据
        self.performanceItems = [
            PerformanceItem(
                title: "《广陵散》",
                performer: "赵家珍",
                eventName: "中央民族乐团古琴之夜",
                location: "深圳",
                date: Self.dateFormatter.date(from: "2024.10.27"),
                coverImage: "经典影像",
                videoURL: nil, // 暂时空缺
                description: "《广陵散》是一首著名的古琴曲，是中国古代十大名曲之一，表现了聂政刺韩王为父报仇的故事，充满了慷慨激昂、悲愤苍凉的复仇情绪。"
            )
            
            ,
            PerformanceItem(
                title: "阳关三叠",
                performer: "李祥霆",
                eventName: "李祥霆古琴音乐会",
                location: "北京",
                date: PerformanceItem.dateFormatter.date(from: "2023.09.10"),
                coverImage: "经典影像", // 使用你统一的图片资源
                videoURL: PerformanceItem.localURL(for: "广陵散", fileExtension: "mov"),
                description: "《阳关三叠》是根据唐代诗人王维的七绝《送元二使安西》谱写的一首琴歌，表达了深厚的离别之情和对友人的美好祝愿。这首曲子旋律优美，意境深远，是古琴曲中的经典代表作。"
            ),
            PerformanceItem(
                title: "《酒狂》",
                performer: "龚一",
                eventName: "古琴名家音乐会",
                location: "上海音乐学院", // 地点更具体一些
                date: Self.dateFormatter.date(from: "2022.11.01"),
                coverImage: "经典影像3", // 确保你在 Assets.xcassets 中有这张图片
                videoURL: nil,
                description: "《酒狂》是阮籍所作的古琴曲，旋律跌宕起伏，表现了酒醉后不拘礼法、佯狂避世的形象。龚一老师的演奏精湛，深得其精髓。"
            )
            
        ]
    }
    
    // 辅助的日期格式化器，用于在 ViewModel 中处理 Date
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}
