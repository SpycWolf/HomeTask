//
//  AddStockView.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddStockView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var quantity: Int = 1
    @State private var memo: String = ""
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    private var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // 画像セクション
                Section {
                    ImagePickerSection(
                        selectedPhotoItem: $selectedPhotoItem,
                        selectedImageData: $selectedImageData
                    )
                } header: {
                    Text("画像")
                }
                
                // 基本情報セクション
                Section {
                    TextField("品名", text: $name)
                    
                    Stepper("個数: \(quantity)", value: $quantity, in: 0...999)
                } header: {
                    Text("基本情報")
                }
                
                // メモセクション
                Section {
                    TextEditor(text: $memo)
                        .frame(minHeight: 80)
                } header: {
                    Text("メモ")
                } footer: {
                    Text("購入時の注意点などを記録できます")
                }
            }
            .navigationTitle("新規ストック")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("追加") {
                        addStock()
                    }
                    .disabled(!isValid)
                    .foregroundStyle(isValid ? AppColors.primary : AppColors.secondary)
                }
            }
            .onChange(of: selectedPhotoItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
        }
    }
    
    // MARK: - Actions
    
    private func addStock() {
        let newStock = Stock(
            name: name.trimmingCharacters(in: .whitespaces),
            quantity: quantity,
            imageData: selectedImageData,
            memo: memo
        )
        modelContext.insert(newStock)
        dismiss()
    }
}

#Preview {
    AddStockView()
        .modelContainer(for: Stock.self, inMemory: true)
}
