//
//  AnalyzeView.swift
//  PicFeed
//
//  Created by 김혜지 on 8/13/25.
//

import SwiftUI

struct AnalyzeView: View {
    @State private var isPresentedPhotoPicker: Bool = false
    @State private var selectedPhoto: UIImage? = nil
    
    private let viewModel: AnalyzeViewModel
    
    init(viewModel: AnalyzeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            if let selectedPhoto {
                VStack(spacing: 20) {
                    Image(uiImage: selectedPhoto)
                        .resizable()
                        .scaledToFit()
                    
                    VStack(spacing: 10) {
                        Button {
                            
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(.gray.opacity(0.5))
                                Text("사진 다시 가져오기")
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 12)
                            }
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        Button {
                            Task {
                                guard let imageData = selectedPhoto.jpegData(compressionQuality: 0.8) else { return }
                                await viewModel.analyze(imageData: imageData)
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(.blue)
                                Text("분석하기")
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 12)
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 20)
                }
            } else {
                Menu {
                    Button("파일에서 가져오기", action: {
                        
                    })
                    Button("갤러리에서 가져오기", action: {
                        isPresentedPhotoPicker = true
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
        .sheet(isPresented: $isPresentedPhotoPicker) {
            PhotoPickerView(isPresented: $isPresentedPhotoPicker, selectedPhoto: $selectedPhoto)
        }
    }
}

#Preview {
    AnalyzeView(viewModel: AnalyzeViewModel(networkClient: URLSessionClient()))
}
