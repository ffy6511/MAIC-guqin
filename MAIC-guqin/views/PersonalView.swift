//
//  PersonalView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/27.
//

import SwiftUI

enum SettingsTab: String, CaseIterable, Identifiable{
    case MyDesign = "我的古琴"
    case SystemSetting = "系统设置"
    
    var id: String { self.rawValue }
}


struct PersonalView: View {
    @EnvironmentObject var appSettings: AppSettings
    @State private var selectedTab: SettingsTab = .MyDesign
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                // 昵称与头像
                VStack {
                    HStack {
                        VStack {
                            NavigationLink(destination: SettingsView()){
                                ProfileAvatarView(size: 100)
                                    .environmentObject(appSettings)
                            }
                            
                            Text(appSettings.settings.nickname)
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        
                        VerticalTextView(
                            appSettings.settings.signature,
                            spacing: 3,
                            maxHeight: 170,
                            enableColumnBreak: true,
                            enableLargerFirstChars: false,
                            largerFirstCharsCount: 2
                        ) { text in
                            text.signatureStyle(showBackground: false, animationEnabled: true)
                        }
                        .padding(.leading, 40)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                    
                    // 选项卡和内容
                    // tab选择器
                      Picker("choose mode", selection: $selectedTab){
                          ForEach(SettingsTab.allCases){tab in
                              Text(tab.rawValue)
                                  .tag(tab)
                          }
                      }
                      .pickerStyle(.segmented)
                      .padding(.horizontal,48)
                      .padding(.bottom,8)
                    
                    
                    Group {
                       switch selectedTab {
                       case .MyDesign:
                           // 古琴定制区域
                           NavigationLink(destination: GuqinCustomizationView()) {
                               VStack(alignment: .leading, spacing: 12) {
                                   HStack {
                                       Image(systemName: "music.note")
                                           .font(.title2)
                                           .foregroundColor(.blue.opacity(0.5))

                                       Text("古琴定制")
                                           .font(.headline)
                                           .foregroundColor(.primary)

                                       Spacer()

                                       Image(systemName: "chevron.right")
                                           .font(.caption)
                                           .foregroundColor(.secondary)
                                   }

                                   Text("设计您专属的古琴，选择形制、材质和琴弦")
                                       .font(.caption)
                                       .foregroundColor(.secondary)
                                       .multilineTextAlignment(.leading)
                                       .frame(maxWidth: .infinity, alignment: .leading)
                               }
                               .padding()
                               .frame(maxWidth: .infinity)
                               .frame(height: 100)
                               .background(
                                   RoundedRectangle(cornerRadius: 12)
                                       .fill(Color(UIColor.systemBackground))
                                       .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
                               )
                               .padding(.horizontal)
                           }
                           .buttonStyle(PlainButtonStyle())

                           // 社区画廊卡片(TODO)
                           VStack(alignment: .leading, spacing: 12) {
                               HStack {
                                   Image(systemName: "photo.on.rectangle.angled")
                                       .font(.title2)
                                       .foregroundColor(.brandSecondary)
                                   Text("社区画廊")
                                       .font(.headline)
                                       .foregroundColor(.primary)
                                   Spacer()
                                   Text("即将上线")
                                       .font(.caption)
                                       .foregroundColor(.secondary)
                                       .padding(.horizontal, 8)
                                       .padding(.vertical, 2)
                                       .background(Color.green.opacity(0.15))
                                       .cornerRadius(6)
                               }
                               
                               Text("浏览和分享来自社区的古琴设计作品")
                                   .font(.caption)
                                   .foregroundColor(.secondary)
                               
                               // 示例缩略图
                               HStack(spacing: 8) {
                                   ForEach(0..<4) { _ in
                                       RoundedRectangle(cornerRadius: 6)
                                           .fill(Color.gray.opacity(0.18))
                                           .frame(width: 48, height: 48)
                                           .overlay(
                                               Image(systemName: "music.note.list")
                                                   .font(.title3)
                                                   .foregroundColor(.gray.opacity(0.4))
                                           )
                                   }
                                   Spacer()
                               }
                           }
                           .padding()
                           .frame(maxWidth: .infinity)
                           .background(
                               RoundedRectangle(cornerRadius: 12)
                                   .fill(Color.white.opacity(0.85))
                                   .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 2)
                           )
                           .padding(.horizontal)

                           
                       case .SystemSetting:
                           Text("系统设置区域")
                               .frame(maxWidth: .infinity)
                               .frame(height: 200)
                               .background(Color.blue.opacity(0.1))
                               .cornerRadius(8)
                               .padding(.horizontal)
                       }
                   }
                   .padding(.bottom) // 内容区域底部间距
                    
                   
                    
                }
            }
            .navigationTitle("我的")
            .navigationBarTitleDisplayMode(.large)
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
}


#Preview {
    PersonalView()
        .environmentObject(AppSettings())
}
