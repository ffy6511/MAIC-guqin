//
//  SettingsView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/6/27.
//
// SettingsView.swift

import SwiftUI
import UIKit

struct SettingsView: View {
    @EnvironmentObject var appSettings: AppSettings // 注入 AppSettings 实例
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showAvatarActionSheet = false
    
    var body: some View {
        Form {
            Section("外观显示") {
                Picker("主题", selection: $appSettings.settings.selectedTheme) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.displayName).tag(theme)
                    }
                }
                
                if UIApplication.shared.supportsAlternateIcons {
                    Picker("应用图标", selection: $appSettings.settings.selectedAppIcon) {
                        ForEach(AppIcon.allCases) { icon in
                            Label(icon.displayName, systemImage: icon.rawValue == "AppIcon" ? "app.fill" : "apps.iphone")
                                .tag(icon)
                        }
                    }
                }
            }
            
            Section("个人资料") {
                // 头像设置行
                HStack {
                    Text("头像")
                    Spacer()
                    Button(action: {
                        showAvatarActionSheet = true
                    }) {
                        appSettings.getUserAvatarSwiftUIImage()
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
                
                HStack {
                    Text("用户")
                    Spacer()
                    TextField("用户名", text: $appSettings.settings.username)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("昵称")
                    Spacer()
                    TextField("昵称", text: $appSettings.settings.nickname)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                }
                
                Picker("性别", selection: $appSettings.settings.gender) {
                    ForEach(Gender.allCases) { gender in
                        Text(gender.rawValue).tag(gender)
                    }
                }
                
                HStack(alignment: .top) {
                    Text("个性签名")
                        .frame(width: 80, alignment: .leading)  // 固定文本宽度
                    
                    TextField("个性签名", text: $appSettings.settings.signature, axis: .vertical)
                        .lineLimit(3)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
            Section("通用设置") {
                Toggle("触控反馈", isOn: $appSettings.settings.hapticFeedbackEnabled)
                
//                if appSettings.settings.hapticFeedbackEnabled {
//                    Button("测试触控反馈") {
//                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
//                        impactMed.impactOccurred()
//                    }
//                }
            }
            
            Section("关于") {
                Text("您已使用本产品 \(appSettings.settings.appUsageDays) 天")
            }
        }
        .navigationTitle("设置")
        .preferredColorScheme(appSettings.settings.selectedTheme.colorScheme)
        .actionSheet(isPresented: $showAvatarActionSheet) {
            ActionSheet(
                title: Text("选择头像"),
                buttons: [
                    .default(Text("使用系统默认")) {
                        appSettings.setSystemDefaultAvatar()
                    },
                    .default(Text("从相册选择")) {
                        showImagePicker = true
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .onChange(of: selectedImage) { _, newImage in
            if let image = newImage {
                appSettings.setCustomAvatar(image)
            }
        }
    }
}

// 图片选择器
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
                .environmentObject(AppSettings()) // 预览时提供 AppSettings 实例
        }
    }
}
