//
//  CustomTabBarItem.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/28.
//

import SwiftUI
import UIKit

struct CustomTabBarItem: View {
    @EnvironmentObject var appSettings: AppSettings

    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    @GestureState private var isPressed = false
    @State private var bounce = false

    var body: some View {
        Button(action: {
            // 触觉反馈
            if appSettings.settings.hapticFeedbackEnabled {
                let impact = UIImpactFeedbackGenerator(style: .light)
                impact.impactOccurred()
            }
            // 触发 bounce 动画
            withAnimation(.spring(response: 0.18, dampingFraction: 0.4, blendDuration: 0.5)) {
                bounce = true
            }
            // 动画结束后还原
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                    bounce = false
                }
            }
            action()
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .semibold))
                Text(title)
                    .font(.caption)
            }
            .padding(.horizontal,24)
            .padding(.vertical,4)
            .foregroundColor(isSelected ? .textInversePrimary.opacity(0.9): .textSecondary)
            .background {
                if isSelected {
                    Capsule()
                        .fill(.ultraThinMaterial.opacity(0.9))
                        .opacity(0.8)
                        .overlay(
                            Capsule().fill(Color.brandSecondary).opacity(0.7)
                        )
                }
            }

            .scaleEffect(isPressed ? 0.85 : (bounce ? 1.03 : 1.0))
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
            .animation(.spring(response: 0.25, dampingFraction: 0.4), value: bounce)
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.01)
                .updating($isPressed) { currentState, gestureState, _ in
                    gestureState = currentState
                }
        )
    }
}
