//
//  ScoreItem.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/26.
//

import Foundation

struct ScoreItem: Identifiable, Codable {
    var id = UUID()
    let title: String
    let image: String
    let tags: [String] // 多个标签
    let practiceCount: Int
    let composer: String?
    let duration: TimeInterval?
    let difficulty: String?
    let description: String?
    
    let pdfURL: URL?
    let musicXMLURL: URL?
    let midiURL: URL?

    // 示例：创建本地文件 URL
    static func localURL(for fileName: String, fileExtension: String) -> URL? {
        // 首先尝试从应用的主Bundle中查找
        if let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
            return url
        }
        
        // 如果主Bundle中没有，尝试从ScoreItem.bundle中查找
        if let bundlePath = Bundle.main.path(forResource: "ScoreItem", ofType: "bundle"),
           let scoreBundle = Bundle(path: bundlePath) {
            return scoreBundle.url(forResource: fileName, withExtension: fileExtension)
        }
        
        return nil
    }
}
