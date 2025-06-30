//
//  RoomBackgroundSettingsView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

// RoomBackgroundSettingsView.swift
import SwiftUI

// RoomBackgroundSettingsView：允许用户配置房间背景的各个层次
struct RoomBackgroundSettingsView: View {
    // 注入 RoomBackgroundManager 实例，以便访问和修改背景状态
    @EnvironmentObject var backgroundManager: RoomBackgroundManager
    
    // 用于控制模态视图（Sheet）的关闭
    @Environment(\.dismiss) var dismiss

    // MARK: - 新增 State：控制当前选中的背景分类（前景、远景、天气）
    enum BackgroundCategory: String, CaseIterable, Identifiable {
        case foreground = "前景主体"
        case distant    = "远处环境"
        case weather    = "天气效果"
        var id: String { self.rawValue }
    }
    
    let frame_height: CFloat = 300
    
    @State private var selectedCategory: BackgroundCategory = .foreground // 默认选中前景主体
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) { // 使用 VStack 来垂直堆叠预览、分类选择和横向滚动列表
                // MARK: - 组合效果预览区域 (放到最上方)
                // 创建一个小型的 ZStack 来模拟 RoomView 的背景叠加效果
                ZStack {
                    // 1. 远处环境层
                    if !backgroundManager.currentConfig.distantElement.frames.isEmpty {
                        Image(backgroundManager.currentConfig.distantElement.frames.first!.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .opacity(0.5)
                            .frame(height: CGFloat(frame_height))
                    } else {
                        Color.gray.opacity(0.1) // 占位背景
                    }
                    
                    // 2. 前景主体层
                    if !backgroundManager.currentConfig.foregroundElement.frames.isEmpty {
                        Image(backgroundManager.currentConfig.foregroundElement.frames.first!.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .opacity(0.7)
                            .frame(height: CGFloat(frame_height))
                    }
                    
                    // 3. 天气效果层 - 根据 weatherEffectType 渲染粒子效果或图片
                    switch backgroundManager.currentConfig.weatherElement.weatherEffectType {
                    case nil:
                        EmptyView() // 无天气效果
                    case .rain:
                         RainEffectView(isEnabled: backgroundManager.isGlobalAnimationEnabled, animationScale: 0.5)
                             .allowsHitTesting(false)
                       
                    case .snow:
                        SnowEffectView(isEnabled: backgroundManager.isGlobalAnimationEnabled, animationScale: 0.5) // 预览时可以调低速度或密度
                            .allowsHitTesting(false) // 防止预览图捕获点击事件
                    case .some: // Fallback for other cases or if weatherEffectType is nil
                        // 如果有基于图片帧的天气效果，这里仍显示第一帧
                        if !backgroundManager.currentConfig.weatherElement.frames.isEmpty {
                            Image(backgroundManager.currentConfig.weatherElement.frames.first!.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .opacity(0.7)
                        } else {
                            EmptyView() // 如果既不是粒子也不是帧动画，则不显示
                        }
                    }
                }
                .frame(height: CGFloat(frame_height))
                .clipped() // 裁剪超出部分
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 12)
                .background(Color(.systemBackground)) // 背景色，使其与 Form 分离
                
                // MARK: - 全局动画开关 (放置在预览下方，不属于 Form)
                // 动画开关仍然是全局性质，可以放在这里
                Toggle("启用背景动画", isOn: $backgroundManager.isGlobalAnimationEnabled)
                    .tint(.green)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(Color(.systemBackground))
                
                Form { // 剩余的分类选择和横向滚动部分放入 Form
                    // MARK: - 主分类 Picker：选择前景/远景/天气
                    Section {
                        Picker("选择配置类型", selection: $selectedCategory) {
                            ForEach(BackgroundCategory.allCases) { category in
                                Text(category.rawValue)
                                    .tag(category)
                            }
                        }
                        .pickerStyle(.segmented) // 分段选择器，更紧凑
                        .padding(.vertical, -5) // 减少一些垂直内边距，使其更紧凑
                    }
                    
                    // MARK: - 横向滚动选择列表（根据 selectedCategory 动态显示）
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) { // 元素之间的间距
                                switch selectedCategory {
                                case .foreground:
                                    ForEach(ForegroundElement.allElements) { element in
                                        // 针对每个元素的自定义卡片视图
                                        ElementSelectionCard(
                                            name: element.name,
                                            imageName: element.frames.first?.imageName ?? "", // 显示第一帧作为预览图
                                            isSelected: backgroundManager.currentConfig.foregroundElement.id == element.id,
                                            isAnimated: element.isAnimated
                                        )
                                        .onTapGesture {
                                            // 点击时更新 backgroundManager 中的对应元素
                                            backgroundManager.currentConfig.foregroundElement = element
                                            // 可选：添加触觉反馈
                                            let impact = UIImpactFeedbackGenerator(style: .light)
                                            impact.impactOccurred()
                                        }
                                    }
                                case .distant:
                                    ForEach(DistantElement.allElements) { element in
                                        ElementSelectionCard(
                                            name: element.name,
                                            imageName: element.frames.first?.imageName ?? "",
                                            isSelected: backgroundManager.currentConfig.distantElement.id == element.id,
                                            isAnimated: element.isAnimated
                                        )
                                        .onTapGesture {
                                            backgroundManager.currentConfig.distantElement = element
                                            let impact = UIImpactFeedbackGenerator(style: .light)
                                            impact.impactOccurred()
                                        }
                                    }
                                case .weather:
                                    ForEach(WeatherElement.allElements) { element in
                                        ElementSelectionCard(
                                            name: element.name,
                                            imageName: element.frames.first?.imageName ?? "",
                                            isSelected: backgroundManager.currentConfig.weatherElement.id == element.id,
                                            isAnimated: element.isAnimated
                                        )
                                        .onTapGesture {
                                            backgroundManager.currentConfig.weatherElement = element
                                            let impact = UIImpactFeedbackGenerator(style: .light)
                                            impact.impactOccurred()
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal) // 滚动视图的内容内边距
                            .padding(.vertical, 5)
                        }
                        .listRowInsets(EdgeInsets()) // 移除 Form 默认的行内边距，让 ScrollView 占据整个宽度
                        .padding(.vertical, -10) // 减少 Form Section 默认的垂直内边距
                    }
                }
            }
            .navigationTitle("环境设置")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("完成") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - 辅助视图：用于显示单个背景元素的选择卡片
// 为了复用代码和保持 RoomBackgroundSettingsView 简洁，我们创建一个子视图
struct ElementSelectionCard: View {
    let name: String
    let imageName: String // 预览图的图片名称
    let isSelected: Bool
    let isAnimated: Bool // 是否是动画元素

    var body: some View {
        VStack(spacing: 5) {
            // 图片预览区域
            ZStack {
                if imageName.isEmpty {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 80, height: 80) // 统一卡片大小
                        .overlay(Text("无")) // 如果没有图片，显示“无”
                } else {
                    Image(imageName) // 使用图片名直接加载预览图
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80) // 统一卡片大小
                        .clipped() // 裁剪超出部分
                        .cornerRadius(10)
                }

                // 选中状态指示器
                if isSelected {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.accentColor, lineWidth: 3) // 选中时高亮边框
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(Color.accentColor)
                                .offset(x: 25, y: -25) // 放置在右上角
                        )
                }

                // 动画指示器 (如果适用)
                if isAnimated {
                    Image(systemName: "play.fill")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                        .offset(x: -25, y: 25) // 放置在左下角
                }
            }
            
            // 元素名称
            Text(name)
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .frame(width: 80) // 确保文本宽度与图片一致
        }
        .padding(.bottom, 5) // 底部留白
    }
}

// MARK: - RoomBackgroundSettingsView 的预览
struct RoomBackgroundSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        // 为了在预览中看到 RoomBackgroundSettingsView，需要提供一个 RoomBackgroundManager 实例
        RoomBackgroundSettingsView()
            .environmentObject(RoomBackgroundManager()) // 注入一个默认的管理器实例
    }
}

