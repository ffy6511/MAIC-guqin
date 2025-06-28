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
    // 通常通过 .environmentObject() 从父视图（如 RoomView）传递过来
    @EnvironmentObject var backgroundManager: RoomBackgroundManager
    
    // 用于控制模态视图（Sheet）的关闭
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView { // 提供导航栏、标题和工具栏按钮
            Form { // 使用 Form 结构化设置界面，提供分组和良好的视觉效果
                // MARK: - 全局动画开关
                Section {
                    Toggle("启用背景动画", isOn: $backgroundManager.isGlobalAnimationEnabled)
                        .tint(.green) // 可选：自定义开关颜色
                } header: {
                    Text("动画设置")
                }
                
                // MARK: - 前景主体分类选择
                Section {
                    // Picker 允许用户从 ForegroundElement.allElements 中选择一个
                    Picker("选择主体", selection: $backgroundManager.currentConfig.foregroundElement) {
                        ForEach(ForegroundElement.allElements) { element in
                            Label {
                                Text(element.name) // 显示元素名称
                            } icon: {
                                // 根据是否动画显示不同的图标
                                if element.isAnimated {
                                    Image(systemName: "play.circle.fill")
                                } else {
                                    Image(systemName: "photo.fill")
                                }
                            }
                            .tag(element) // 使用整个 element 作为标签值
                        }
                    }
                } header: {
                    Text("前景主体")
                }
                
                // MARK: - 远处环境分类选择
                Section {
                    Picker("选择远景", selection: $backgroundManager.currentConfig.distantElement) {
                        ForEach(DistantElement.allElements) { element in
                            Label {
                                Text(element.name)
                            } icon: {
                                // 远景通常是静态，使用山峦图标
                                Image(systemName: "mountain.2.fill")
                            }
                            .tag(element)
                        }
                    }
                } header: {
                    Text("远处环境")
                }
                
                // MARK: - 天气效果分类选择
                Section {
                    Picker("选择天气", selection: $backgroundManager.currentConfig.weatherElement) {
                        ForEach(WeatherElement.allElements) { element in
                            Label {
                                Text(element.name)
                            } icon: {
                                // 根据是否动画显示不同的图标，天气多为动画
                                if element.isAnimated {
                                    Image(systemName: "cloud.bolt.fill")
                                } else {
                                    Image(systemName: "cloud.fill")
                                }
                            }
                            .tag(element)
                        }
                    }
                } header: {
                    Text("天气效果")
                }
                
                // MARK: - 实时预览 (可选，但非常推荐，复杂性较高)
                Section {
                    // 这个区域可以用于显示当前组合的背景实时预览
                    // 注意：这里只是一个占位文本，实际实现会更复杂，
                    // 可能需要一个独立的子视图来模拟 RoomView 的背景渲染逻辑。
                    Text("背景预览区域：\n前景: \(backgroundManager.currentConfig.foregroundElement.name)\n远景: \(backgroundManager.currentConfig.distantElement.name)\n天气: \(backgroundManager.currentConfig.weatherElement.name)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                    // 简化预览：直接显示当前背景的某个静态图或组合图
                    // 更高级的预览可能需要将 RoomBackgroundManager 中的图片获取逻辑封装到子视图中
                } header: {
                    Text("当前组合效果")
                }
            }
            .navigationTitle("环境设置") // 导航栏标题
            .navigationBarTitleDisplayMode(.inline) // 标题显示模式
            .toolbar { // 导航栏工具栏
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("完成") {
                        dismiss() // 点击“完成”按钮关闭当前模态视图
                    }
                }
            }
        }
    }
}

// MARK: - RoomBackgroundSettingsView 的预览
struct RoomBackgroundSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        // 为了在预览中看到 RoomBackgroundSettingsView，需要提供一个 RoomBackgroundManager 实例
        // 这里的实例是临时的，不会影响实际运行中的 RoomBackgroundManager
        RoomBackgroundSettingsView()
            .environmentObject(RoomBackgroundManager()) // 注入一个默认的管理器实例
    }
}
