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
                           Text("古琴设计区域")
                               .frame(maxWidth: .infinity)
                               .frame(height: 150)
                               .background(Color.gray.opacity(0.1))
                               .cornerRadius(8)
                               .padding(.horizontal)
                           
                           Text("社区画廊")
                               .frame(maxWidth: .infinity)
                               .frame(height: 150)
                               .background(Color.gray.opacity(0.1))
                               .cornerRadius(8)
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
