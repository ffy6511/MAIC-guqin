//
//  RecentPracticeSection.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/24.
//

import SwiftUI


struct RecentPracticeSection: View {
    let title: String = "最近练习"
    @StateObject private var viewModel = RecentPracticeListViewModel() // 拥有自己的 ViewModel 实例

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title2)
                    .padding(.horizontal)
                    .foregroundColor(Color("TextSecondary"))
                
                Spacer()
                Button {
                    viewModel.refreshPractices()
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color("TextSecondary"))
                }
            }
            .padding(.horizontal)

            VStack(spacing: 4) {
                ForEach(viewModel.practices) { item in
                    RecentPracticeItem(item: item) // 将整个 Model item 传递给 Item
                }
            }
            .padding(.horizontal)
        }
//        .padding(.vertical)
    }
}

#Preview {
    RecentPracticeSection()
}
