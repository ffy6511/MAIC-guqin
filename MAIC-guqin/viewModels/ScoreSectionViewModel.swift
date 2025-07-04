//
// ScoreSectionViewModel.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/26.
//

import Foundation

class ScoreSectionViewModel: ObservableObject {
    @Published var scoreItems: [ScoreItem]

    init() {
        // 硬编码一个 ScoreItem 示例数据，作为列表中的唯一项
        self.scoreItems = [
            ScoreItem(
                title: "广陵散",
                image: "曲谱",
                tags: ["十大古琴名曲", "古琴考级十级曲目"],
                practiceCount: 11364,
                composer: "嵇康",
                duration: 600,
                difficulty: "高级",
                description: "《广陵散》是中国十大古琴名曲之一，旋律激昂慷慨，是不可多得的艺术珍品。",
                pdfURL: ScoreItem.localURL(for: "广陵散曲谱", fileExtension: "pdf"), // 确保文件存在
                musicXMLURL: nil,
                midiURL: nil
            )
        ]

        
        self.scoreItems.append(
            ScoreItem(
                title: "阳关三叠",
                image: "阳关三叠-曲谱封面",
                tags: ["十大古琴名曲", "古琴考级四级曲目"],
                practiceCount: 3532,
                composer: "王维",
                duration: 360,
                difficulty: "中级",
                description: "《阳关三叠》是根据唐代诗人王维的七言绝句《送元二使安西》谱写的一首艺术歌曲，以琴歌形式流传至今。",
                pdfURL: ScoreItem.localURL(for: "yangguan_sandie_score", fileExtension: "pdf"),
                musicXMLURL: ScoreItem.localURL(for: "yangguan_sandie_score", fileExtension: "musicxml"),
                midiURL: nil
            )
        )
    }
}
