//
//  RoomView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import SwiftUI
import UIKit // 用于触控反馈
import Combine // 用于订阅 RoomBackgroundManager

struct RoomView: View {
    @StateObject private var backgroundManager = RoomBackgroundManager()
    
    // 控制模态视图的显示状态
    @State private var showingBackgroundSettings: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 1. 顶部标题栏
                HStack {
                   
                    Spacer()
                    
                    Button(action: {
                        // 设置按钮动作
                    }) {
                        Image(systemName: "gearshape")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // VR连接状态指示
                HStack {
                    Spacer()
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                    Text("VR设备已连接")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 5)
                
                // 2. 上方环境预览区域
                ZStack {
                    // 背景环境层
                    if !backgroundManager.currentDistantImageName.isEmpty {
                        Image(backgroundManager.currentDistantImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 400)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.mint.opacity(0.3), Color.green.opacity(0.2)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(height: 400)
                    }
                    
                    // 前景主体层
                    if !backgroundManager.currentForegroundImageName.isEmpty {
                        Image(backgroundManager.currentForegroundImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 350)
                            .allowsHitTesting(false)
                    }
                    
                    // 天气效果层
                    if backgroundManager.isGlobalAnimationEnabled {
                        switch backgroundManager.currentWeatherEffectType {
                        case .none:
                            EmptyView()
                        case .rain:
                            RainEffectView(isEnabled: backgroundManager.isGlobalAnimationEnabled, animationScale: 0.5)
                                .allowsHitTesting(false)
                                .frame(height: 300)
                        case .snow:
                            SnowEffectView(isEnabled: true, animationScale: 1.0)
                                .allowsHitTesting(false)
                                .frame(height: 300)
                        }
                    }
                    
                    // 右侧垂直文字 "博雅轩"
                    HStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Text("博")
                                .font(.title)
                                .fontWeight(.light)
                                .foregroundColor(.black.opacity(0.6))
                            Text("雅")
                                .font(.title)
                                .fontWeight(.light)
                                .foregroundColor(.black.opacity(0.6))
                            Text("轩")
                                .font(.title)
                                .fontWeight(.light)
                                .foregroundColor(.black.opacity(0.6))
                        }
                        .padding(.trailing, 30)
                    }
                    
                    // 中央暂停按钮
                    Button(action: {
                        // 暂停/播放动作
                    }) {
                        Image(systemName: "pause.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.white.opacity(0.3))
                            .clipShape(Circle())
                            .background(
                                Circle()
                                    .stroke(Color.white.opacity(0.5), lineWidth: 2)
                            )
                    }
                }
                .frame(height: 300)
                
                // 3. 中间古琴区域
                ZStack {
                    // 背景渐变
                    LinearGradient(
                        colors: [Color.clear, Color.gray.opacity(0.1)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    // 古琴图片占位符
                    Image(systemName: "music.note") // 临时占位符，替换为实际古琴图片
                        .font(.system(size: 80))
                        .foregroundColor(.black.opacity(0.7))
                        .padding(.vertical, 40)
                    
                    // 如果有实际古琴图片，使用以下代码：
                    /*
                    Image("guqin_placeholder") // 替换为你的古琴图片名
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .padding(.horizontal, 40)
                    */
                }
                .frame(maxHeight: .infinity)
                
                // 4. 底部三个按钮 - 保持原来的文字内容，优化样式，添加导航跳转
                HStack(spacing: 16) {
                    // 环境系统按钮
                    NavigationLink(destination: RoomBackgroundSettingsView().environmentObject(backgroundManager)) {
                        VStack(spacing: 8) {
                            Image(systemName: "cloud.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                            Text("环境系统")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        let impact = UIImpactFeedbackGenerator(style: .light)
                        impact.impactOccurred()
                    })
                    
                    // 情景录制按钮
                    NavigationLink(destination: ScenarioRecordingView()) {
                        VStack(spacing: 8) {
                            Image(systemName: "mic.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                            Text("情景录制")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        let impact = UIImpactFeedbackGenerator(style: .light)
                        impact.impactOccurred()
                    })
                    
                    // 多人琴室按钮
                    NavigationLink(destination: MultiplayerRoomView()) {
                        VStack(spacing: 8) {
                            Image(systemName: "person.3.fill")
                                .font(.title2)
                                .foregroundColor(.green)
                            Text("多人琴室")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        let impact = UIImpactFeedbackGenerator(style: .light)
                        impact.impactOccurred()
                    })
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30) // 增加底部间距，因为没有导航栏了
            }
            .onAppear {
                backgroundManager.setupAnimationTimers()
            }
            .onDisappear {
                backgroundManager.stopAllTimers()
            }
            .sheet(isPresented: $showingBackgroundSettings) {
                RoomBackgroundSettingsView()
                    .environmentObject(backgroundManager)
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
                .ignoresSafeArea()
            )
            // 设置 NavigationStack 的导航栏标题
            .navigationTitle("虚拟琴室")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// 临时占位的视图

struct ScenarioRecordingView: View {
    var body: some View {
        VStack {
            Text("情景录制页面")
                .font(.title)
                .padding()
            Text("这里将显示情景录制的相关功能")
                .foregroundColor(.secondary)
            Spacer()
        }
        .navigationTitle("情景录制")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MultiplayerRoomView: View {
    var body: some View {
        VStack {
            Text("多人琴室页面")
                .font(.title)
                .padding()
            Text("这里将显示多人琴室的相关功能")
                .foregroundColor(.secondary)
            Spacer()
        }
        .navigationTitle("多人琴室")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview
struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
    }
}
