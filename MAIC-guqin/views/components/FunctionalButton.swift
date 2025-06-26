//
// FunctionalButton.swift
// MAIC-guqin
//
// Created by Zhuo on 2025/6/24.
//

import SwiftUI

struct FunctionalButton: View {
    let title: String
    let icon: String
    let action: () -> Void // 添加闭包，用于后续的点击逻辑处理

    var body: some View {
        Button(action: action) { // 将 Button 的 action 绑定到这个闭包
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(Color("TextInversePrimary"))
                        .padding(10)
                        .shadow(radius: 2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Spacer()

                    Text(title)
                        .font(.footnote)
                        .lineLimit(1)
                        .minimumScaleFactor(0.9) // 空间不足时缩小字体
                        .foregroundColor(Color("TextInversePrimary"))
                        .shadow(radius: 2)
                }
                .padding(.horizontal, 8)
                .offset(y: -12)
            }
        }
        .aspectRatio(3/2, contentMode: .fit) // 固定宽高比为3/2
        .background(Color("BrandPrimary").opacity(0.9)) // 确保 "BrandPrimary" 颜色在 Assets 中定义
        .cornerRadius(8)
        .shadow(radius: 4)
        .frame(minHeight: 60)
    }
}

struct FunctionalButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FunctionalButton(title: "练习模式", icon: "music.note.list") {
                // 这是点击“练习模式”按钮时会执行的闭包
                // 在预览中通常可以放一个空的 print 语句或留空
                print("练习模式按钮被点击了 (Preview)")
            }
            .previewLayout(.sizeThatFits) // 让预览尺寸适应内容
            .padding() // 添加一些内边距，以便在预览中更好地查看
            .previewDisplayName("练习模式按钮")

            FunctionalButton(title: "音阶模式", icon: "scale.3d") {
                // 这是点击“音阶模式”按钮时会执行的闭包
                print("音阶模式按钮被点击了 (Preview)")
            }
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("音阶模式按钮")
        }
    }
}
