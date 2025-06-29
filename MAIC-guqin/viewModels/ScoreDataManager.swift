//
//  ScoreDataManager.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/29.
//

import Foundation

class ScoreDataManager: ObservableObject {
    @Published var allScores: [ScoreItem] = []
    
    init() {
        loadSampleData()
    }
    
    // 根据标签获取曲谱列表
    func getScores(for tag: String) -> [ScoreItem] {
        return allScores.filter { $0.tags.contains(tag) }
    }
    
    // 获取所有标签
    func getAllTags() -> [String] {
        let allTags = allScores.flatMap { $0.tags }
        return Array(Set(allTags)).sorted()
    }
    
    // 加载示例数据
    private func loadSampleData() {
        allScores = [
            ScoreItem(
                title: "《广陵散》",
                image: "曲谱",
                tags: ["十大古琴名曲", "古琴考级十级曲目", "经典曲目"],
                practiceCount: 11364,
                composer: "嵇康",
                duration: 600,
                difficulty: "高级",
                description: "《广陵散》是中国十大古琴名曲之一。",
                pdfURL: ScoreItem.localURL(for: "styx", fileExtension: "pdf"),
                musicXMLURL: nil,
                midiURL: nil
            ),
            ScoreItem(
                title: "《高山流水》",
                image: "曲谱",
                tags: ["十大古琴名曲", "经典曲目"],
                practiceCount: 8520,
                composer: "俞伯牙",
                duration: 480,
                difficulty: "中级",
                description: "《高山流水》是另一首著名古琴曲。",
                pdfURL: nil,
                musicXMLURL: nil,
                midiURL: nil
            ),
            ScoreItem(
                title: "《梅花三弄》",
                image: "曲谱",
                tags: ["十大古琴名曲", "古琴考级十级曲目"],
                practiceCount: 7230,
                composer: "桓伊",
                duration: 420,
                difficulty: "高级",
                description: "《梅花三弄》以梅花的洁白芬芳和耐寒等特征。",
                pdfURL: nil,
                musicXMLURL: nil,
                midiURL: nil
            )
            // 添加更多示例数据...
        ]
    }
}
