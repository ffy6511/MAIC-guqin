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
                description: "赵家珍老师在中央民族乐团古琴之夜的《广陵散》演奏，气势磅礴，技艺精湛。"
            )
            
            ,
            PerformanceItem(
                title: "《阳关三叠》",
                performer: "李某某",
                eventName: nil,
                location: "北京",
                date: Self.dateFormatter.date(from: "2023.08.15"),
                coverImage: "经典影像2",
                videoURL: nil, // 暂时空缺
                description: "李某某大师深情演绎《阳关三叠》。"
            ),
            PerformanceItem(
                title: "《酒狂》",
                performer: "王某某",
                eventName: "古琴名家音乐会",
                location: "上海",
                date: Self.dateFormatter.date(from: "2022.11.01"),
                coverImage: "经典影像3",
                videoURL: nil, // 暂时空缺
                description: "王某某教授的古琴曲《酒狂》，潇洒不羁。"
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
