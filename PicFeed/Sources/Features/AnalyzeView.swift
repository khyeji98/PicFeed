//
//  AnalyzeView.swift
//  PicFeed
//
//  Created by 김혜지 on 8/13/25.
//

import SwiftUI

struct AnalyzeView: View {
    var body: some View {
        Menu {
            Button("파일에서 가져오기", action: {
                
            })
            Button("갤러리에서 가져오기", action: {
                
            })
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray.opacity(0.5))
                VStack(spacing: 20) {
                    Spacer()
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 150)
                    Text("사진 가져오기")
                    Spacer()
                }
                .foregroundStyle(.white)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 50)
    }
}

#Preview {
    AnalyzeView()
}
