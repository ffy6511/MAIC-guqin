//
// ScoreDetailView.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/26.
//

import SwiftUI

struct ScoreDetailView: View {
    let scoreItem: ScoreItem // 接收要显示的曲谱数据
    

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 曲谱封面大图
                Image(scoreItem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit) // 适应宽度，保持比例
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.bottom, 10)

                // 标题
//                Text(scoreItem.title)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(Color("TextPrimary"))



                // 标签
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 8) {
                        ForEach(scoreItem.tags, id: \.self) { tag in
                            NavigationLink(destination: TaggedScoresView(tag: tag)) {
                                Text(tag)
                                    .font(.subheadline)
                                    .foregroundColor(Color("BrandPrimary"))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 7)
                                    .background(Color("BackgroundTertiary"))
                                    .cornerRadius(.infinity)
                                    .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: 2)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal) // 保持ScrollView的内边距
                }

                // 作曲家
                if let composer = scoreItem.composer {
                    Text("作曲家: \(composer)")
                        .font(.headline)
                        .foregroundColor(Color("TextSecondary"))
                }
                
                // 跟练人数
                Text("跟练人数: \(scoreItem.practiceCount)")
                    .font(.subheadline)
                    .foregroundColor(Color("TextTertiary"))

                // 时长
                if let duration = scoreItem.duration {
                    Text("时长: \(formatDuration(duration))") // 辅助函数格式化时长
                        .font(.subheadline)
                        .foregroundColor(Color("TextTertiary"))
                }

                // 难度
                if let difficulty = scoreItem.difficulty {
                    Text("难度: \(difficulty)")
                        .font(.subheadline)
                        .foregroundColor(Color("TextTertiary"))
                }

                // 描述
                if let description = scoreItem.description {
                    Text("简介:")
                        .font(.headline)
                        .padding(.top, 10)
                    Text(description)
                        .font(.body)
                        .foregroundColor(Color("TextSecondary"))
                        .lineLimit(nil) // 允许无限行
                }

                // PDF 和 MusicXML 文件链接 (作为按钮或简单的Text)
                VStack(alignment: .leading, spacing: 10) {
                    if let pdfURL = scoreItem.pdfURL {
                        Button(action: {
                            // 在这里处理 PDF 打开逻辑，例如使用 Safari 或内置 PDF 查看器
                            print("打开 PDF: \(pdfURL.absoluteString)")
                            // 实际应用中可以：
                            // UIApplication.shared.open(pdfURL) // 打开外部应用
                            // 或者通过 Sheet 模态展示 PDF 阅读器
                        }) {
                            Label("查看曲谱 (PDF)", systemImage: "doc.text.fill")
                                .font(.body)
                                .foregroundColor(Color("BrandPrimary"))
                        }
                    }

                    if let musicXMLURL = scoreItem.musicXMLURL {
                        Button(action: {
                            // 在这里处理 MusicXML 播放或解析逻辑
                            print("播放 MusicXML: \(musicXMLURL.absoluteString)")
                            // 实际应用中可以：
                            // 启动内置的音乐播放引擎或乐谱解析器
                        }) {
                            Label("播放/互动 (MusicXML)", systemImage: "music.note.list")
                                .font(.body)
                                .foregroundColor(Color("BrandPrimary"))
                        }
                    }

                    if let midiURL = scoreItem.midiURL {
                        Button(action: {
                            print("播放 MIDI: \(midiURL.absoluteString)")
                        }) {
                            Label("播放 (MIDI)", systemImage: "waveform.circle.fill")
                                .font(.body)
                                .foregroundColor(Color("BrandPrimary"))
                        }
                    }
                }
                .padding(.top, 20)

                Spacer() // 将内容推到顶部
            }
            .padding()
            .navigationTitle(scoreItem.title) // 在导航栏显示标题
            .navigationBarTitleDisplayMode(.inline) // 标题显示模式
        }
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

    // 辅助函数：格式化 TimeInterval 为更友好的字符串（例如 "10分0秒"）
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return "\(minutes)分\(seconds)秒"
    }
}

struct ScoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleItem = ScoreItem(
            title: "《广陵散》",
            image: "曲谱", // 确保 Assets 中有此图片
            tags: ["十大古琴名曲", "古琴考级十级曲目"],
            practiceCount: 11364,
            composer: "嵇康",
            duration: 600,
            difficulty: "高级",
            description: "《广陵散》是中国十大古琴名曲之一，旋律激昂慷慨，具有极高的艺术价值和历史地位，是古琴曲中的代表作之一。",
            pdfURL: ScoreItem.localURL(for: "styx", fileExtension: "pdf"),
            musicXMLURL: ScoreItem.localURL(for: "dummy_musicxml_score", fileExtension: "musicxml"),
            midiURL: ScoreItem.localURL(for: "dummy_midi_score", fileExtension: "midi")
        )

        // 在预览中，你需要一个 NavigationStack 来正确预览详情页的导航栏
        NavigationStack {
            ScoreDetailView(scoreItem: sampleItem)
               
        }
    }
}
