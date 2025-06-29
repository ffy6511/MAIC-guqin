//
//  TaggedScoresView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/29.
//

import SwiftUI

struct TaggedScoresView: View {
    let tag: String
    
    
    @EnvironmentObject var scoreDataManager: ScoreDataManager
    @State private var scores: [ScoreItem] = []  // 用状态变量存储数据
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(scores) { item in
                    NavigationLink(destination: ScoreDetailView(scoreItem: item)) {
                        ScoreItemCard(item: item)
                    }
                    .buttonStyle(PlainButtonStyle()) // 移除默认按钮样式
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
        .onAppear {
            // 在视图出现时获取数据
            scores = scoreDataManager.getScores(for: tag)
        }
        .navigationTitle("标签: \(tag)")
        .navigationBarTitleDisplayMode(.inline)
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
            .ignoresSafeArea()
        )
    }
}

#Preview {
    let sampleScores = [
        ScoreItem(
            title: "《广陵散》",
            image: "曲谱",
            tags: ["十大古琴名曲", "古琴考级十级曲目"],
            practiceCount: 11364,
            composer: "嵇康",
            duration: 600,
            difficulty: "高级",
            description: "《广陵散》是中国十大古琴名曲之一。",
            pdfURL: nil,
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
        )
    ]
    
    NavigationStack {
        TaggedScoresView(tag: "十大古琴名曲")
            .environmentObject(ScoreDataManager())
    }
}
