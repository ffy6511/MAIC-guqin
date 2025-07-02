//
//  ProfileAvatarView.swift
//  MAIC-guqin
//
//  Created by Zhuo on 2025/7/2.
//

import SwiftUI

struct ProfileAvatarView: View {
    @EnvironmentObject var appSettings: AppSettings
    let size: CGFloat
    
    var body: some View {
        appSettings.getUserAvatarSwiftUIImage()
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}





