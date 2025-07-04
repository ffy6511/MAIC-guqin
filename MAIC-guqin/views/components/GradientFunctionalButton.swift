//
//  GradientFunctionalButton.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/4.
//
import SwiftUI

struct GradientFunctionalButton: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topLeading) {
                // 渐变背景
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.brandPrimary, .brandSecondary]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(radius: 6)

                // 图标
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 0))
                    .shadow(radius: 4)
            }
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(title)
                            .font(.headline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color.white.opacity(0.9))
                            .shadow(radius: 2)
                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 16))
                    }
                }
            )
            .aspectRatio(3/2, contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 8)
        }
    }
}

struct GradientFunctionalButton_Previews: PreviewProvider {
    static var previews: some View {
        GradientFunctionalButton(title: "实物扫描", icon: "camera.viewfinder") {
            print("实物扫描按钮点击")
        }
        .frame(width: 160, height: 120)
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
