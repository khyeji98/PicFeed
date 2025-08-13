//
//  PhotoPickerView.swift
//  PicFeed
//
//  Created by 김혜지 on 8/13/25.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var selectedPhoto: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        configuration.edgesWithoutContentMargins = .all
        let vc = PHPickerViewController(configuration: configuration)
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    final class Coordinator: NSObject, PHPickerViewControllerDelegate {
        private let parent: PhotoPickerView
        
        init(parent: PhotoPickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let asset = results.first else { return }
            let provider = asset.itemProvider
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                    if let error {
                        print("PHAsset UIImage 로드 실패 --> \(error)")
                    } else {
                        guard let self, let uiImage = object as? UIImage else { return }
                        parent.selectedPhoto = uiImage
                        parent.isPresented = false
                    }
                }
            } else {
                print("PHAsset UIImage 로드 실패")
            }
        }
    }
}
