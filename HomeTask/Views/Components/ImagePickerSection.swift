//
//  ImagePickerSection.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI
import PhotosUI

struct ImagePickerSection: View {
    @Binding var selectedPhotoItem: PhotosPickerItem?
    @Binding var selectedImageData: Data?
    var existingImageData: Data?
    var onRemove: (() -> Void)?
    
    private var displayImageData: Data? {
        selectedImageData ?? existingImageData
    }
    
    var body: some View {
        VStack {
            if let imageData = displayImageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Button("画像を削除", role: .destructive) {
                    selectedPhotoItem = nil
                    selectedImageData = nil
                    onRemove?()
                }
                .font(.caption)
            }
            
            PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                Label(
                    displayImageData == nil ? "画像を選択" : "画像を変更",
                    systemImage: "photo"
                )
                .foregroundStyle(AppColors.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}

#Preview {
    @Previewable @State var photoItem: PhotosPickerItem? = nil
    @Previewable @State var imageData: Data? = nil
    
    Form {
        Section("画像") {
            ImagePickerSection(
                selectedPhotoItem: $photoItem,
                selectedImageData: $imageData
            )
        }
    }
}
