//
//  VerticalTextStyle.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/2.
//

import SwiftUI

struct VerticalTextView<Content: View>: View {
    let text: String
    let spacing: CGFloat
    let maxHeight: CGFloat?
    let enableColumnBreak: Bool
    let columnBreakSymbols: [String]
    let enableLargerFirstChars: Bool
    let largerFirstCharsCount: Int
    let textModifier: (Text) -> Content
    
    init(
        _ text: String,
        spacing: CGFloat = 2,
        maxHeight: CGFloat? = nil,
        enableColumnBreak: Bool = false,
        columnBreakSymbols: [String] = ["，", ","],
        enableLargerFirstChars: Bool = false,
        largerFirstCharsCount: Int = 1,
        @ViewBuilder textModifier: @escaping (Text) -> Content
    ) {
        self.text = text
        self.spacing = spacing
        self.maxHeight = maxHeight
        self.enableColumnBreak = enableColumnBreak
        self.columnBreakSymbols = columnBreakSymbols
        self.enableLargerFirstChars = enableLargerFirstChars
        self.largerFirstCharsCount = largerFirstCharsCount
        self.textModifier = textModifier
    }
    
    var body: some View {
        if let maxHeight = maxHeight {
            // 多列布局
            MultiColumnVerticalText(
                text: text,
                spacing: spacing,
                maxHeight: maxHeight,
                enableColumnBreak: enableColumnBreak,
                columnBreakSymbols: columnBreakSymbols,
                enableLargerFirstChars: enableLargerFirstChars,
                largerFirstCharsCount: largerFirstCharsCount,
                textModifier: textModifier
            )
        } else {
            // 单列布局
            VStack(spacing: spacing) {
                ForEach(Array(text.enumerated()), id: \.offset) { index, character in
                    let isLargerChar = enableLargerFirstChars && index < largerFirstCharsCount
                    
                    if isLargerChar {
                        textModifier(Text(String(character)))
                            .font(.system(size: 20, weight: .medium)) // 加大字号
                    } else {
                        textModifier(Text(String(character)))
                    }
                }
            }
        }
    }
}

struct MultiColumnVerticalText<Content: View>: View {
    let text: String
    let spacing: CGFloat
    let maxHeight: CGFloat
    let enableColumnBreak: Bool
    let columnBreakSymbols: [String]
    let enableLargerFirstChars: Bool
    let largerFirstCharsCount: Int
    let textModifier: (Text) -> Content
    
    // 估算每个字符的高度（包括间距）
    private var estimatedCharHeight: CGFloat { 16 + spacing }
    private var maxCharsPerColumn: Int { max(1, Int(maxHeight / estimatedCharHeight)) }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // 从右到左显示列，所以要反转列的顺序
            ForEach(textColumns.indices.reversed(), id: \.self) { columnIndex in
                VStack(spacing: spacing) {
                    ForEach(Array(textColumns[columnIndex].enumerated()), id: \.offset) { charIndex, characterInfo in
                        let isLargerChar = enableLargerFirstChars && characterInfo.originalIndex < largerFirstCharsCount
                        
                        if isLargerChar {
                            textModifier(Text(String(characterInfo.character)))
                                .font(.system(size: 20, weight: .medium)) // 加大字号
                        } else {
                            textModifier(Text(String(characterInfo.character)))
                        }
                    }
                }
            }
        }
        .frame(maxHeight: maxHeight)
    }
    
    // 字符信息结构体，包含字符和原始索引
    private struct CharacterInfo {
        let character: Character
        let originalIndex: Int
    }
    
    private var textColumns: [[CharacterInfo]] {
        let characters = Array(text.enumerated().map { CharacterInfo(character: $1, originalIndex: $0) })
        var columns: [[CharacterInfo]] = []
        var currentColumn: [CharacterInfo] = []
        
        if enableColumnBreak {
            // 启用分隔符换列功能
            for characterInfo in characters {
                let charString = String(characterInfo.character)
                
                // 检查是否是分隔符
                if columnBreakSymbols.contains(charString) {
                    // 将分隔符添加到当前列
                    currentColumn.append(characterInfo)
                    // 结束当前列
                    if !currentColumn.isEmpty {
                        columns.append(currentColumn)
                        currentColumn = []
                    }
                } else {
                    currentColumn.append(characterInfo)
                    
                    // 检查是否达到最大字符数
                    if currentColumn.count >= maxCharsPerColumn {
                        columns.append(currentColumn)
                        currentColumn = []
                    }
                }
            }
            
            // 添加最后一列（如果有剩余字符）
            if !currentColumn.isEmpty {
                columns.append(currentColumn)
            }
        } else {
            // 原有的按字符数分列逻辑
            for i in stride(from: 0, to: characters.count, by: maxCharsPerColumn) {
                let endIndex = min(i + maxCharsPerColumn, characters.count)
                columns.append(Array(characters[i..<endIndex]))
            }
        }
        
        return columns
    }
}

// 便捷初始化器
extension VerticalTextView where Content == Text {
    init(
        _ text: String,
        spacing: CGFloat = 2,
        maxHeight: CGFloat? = nil,
        enableColumnBreak: Bool = false,
        columnBreakSymbols: [String] = ["，", ","],
        enableLargerFirstChars: Bool = false,
        largerFirstCharsCount: Int = 1
    ) {
        self.text = text
        self.spacing = spacing
        self.maxHeight = maxHeight
        self.enableColumnBreak = enableColumnBreak
        self.columnBreakSymbols = columnBreakSymbols
        self.enableLargerFirstChars = enableLargerFirstChars
        self.largerFirstCharsCount = largerFirstCharsCount
        self.textModifier = { $0 }
    }
}
