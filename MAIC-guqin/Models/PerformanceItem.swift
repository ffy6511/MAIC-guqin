//
// PerformanceItem.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/27.
//

import Foundation

// 大师演奏-经典影像
struct PerformanceItem: Identifiable, Codable {
    var id = UUID()

    let title: String
    let performer: String
    let eventName: String? // 演出/活动名称 (可选)
    let location: String? // 地点(可选)
    let date: Date? // 时间，使用 Date 类型方便处理日期和时间 (可选)
    
    let coverImage: String
    
    // 核心播放资源 URL，可以是本地文件或网络 URL
    let videoURL: URL? // 视频文件 URL，例如 mp4, mov (本地或网络)
    let description: String? // 视频内容的简要描述 (可选)

    // 辅助函数：用于创建本地文件 URL
    static func localURL(for fileName: String, fileExtension: String) -> URL? {
        return Bundle.main.url(forResource: fileName, withExtension: fileExtension)
    }

    // 辅助函数：用于日期格式化
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd" // 例如 "2024.10.27"
        return formatter
    }()
}

/*
// 示例用法：
let samplePerformance = PerformanceItem(
    title: "《春风》",
    performer: "赵家珍",
    eventName: "中央民族乐团古琴之夜",
    location: "深圳",
    date: PerformanceItem.dateFormatter.date(from: "2024.10.27"),
    coverImage: "zhaojiazhen_chunfeng_cover", // 确保 Assets 中有此图片
    videoURL: PerformanceItem.localURL(for: "chunfeng_video", fileExtension: "mp4"),
    description: "赵家珍老师在深圳的精彩古琴演奏《春风》。"
)

// 如果是网络视频，videoURL 可以直接是网络URL字符串转化的 URL
// let networkPerformance = PerformanceItem(
//     title: "《渔樵问答》",
//     performer: "某某大师",
//     eventName: nil,
//     location: nil,
//     date: nil,
//     coverImage: "yujiaowenda_network_cover",
//     videoURL: URL(string: "https://example.com/videos/yujiaowenda.mp4"),
//     description: "网络视频示例。"
// )
*/
