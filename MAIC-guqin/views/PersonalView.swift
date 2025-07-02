//
//  PersonalView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/27.
//

import SwiftUI

struct PersonalView: View {
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                // 昵称与头像
                HStack {
                    VStack {
                        ProfileAvatarView(size: 120)
                            .environmentObject(appSettings)
                        Text(appSettings.settings.nickname)
                            .font(.headline)
                            .foregroundColor(.primary)
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
