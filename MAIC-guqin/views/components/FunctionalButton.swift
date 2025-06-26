//
//  FunctionalButton.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//


import SwiftUI

struct FunctionalButton: View {
    let title: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(Color("TextInversePrimary"))
                    .padding(10)
                    .shadow(radius: 2)
            }
            
            
            HStack {
                Spacer()
                
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.textInversePrimary)
                    .shadow(radius: 2)
            }
            .padding(.horizontal, 8)
            .offset( y:-12)
        }
        .frame(width: 100, height: 60)
        .background(.brandPrimary.opacity(0.9))
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct FunctionalButton_Previews: PreviewProvider{
    static var previews: some View{
        Group{
            FunctionalButton(title: "练习模式", icon: "music.note.list")
                .previewLayout(.sizeThatFits) // 让预览尺寸适应内容
                .padding() // 添加一些内边距，以便在预览中更好地查看
                .previewDisplayName("练习模式按钮")
            
            FunctionalButton(title: "音阶模式", icon: "scale.3d")
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("音阶模式按钮")
        }
    }
}
