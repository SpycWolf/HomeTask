//
//  EditStockView.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditStockView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var stock: Stock
    var onDelete: (() -> Void)?
    
    @State private var name: String = ""
    @State private var quantity: Int = 0
    @State private var memo: String = ""
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var imageWasRemoved: Bool = false
    @State private var showingDeleteAlert: Bool = false
    
    private var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // 画像セクション
                Section {
                    imagePickerSection
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
                
                // 削除セクション
                Section {
                    Button(role: .destructive) {
                        showingDeleteAlert = true
                    } label: {
                        HStack {
                            Spacer()
                            Label("このストックを削除", systemImage: "trash")
                                .foregroundStyle(AppColors.danger)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("ストックを編集")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        saveChanges()
                    }
                    .disabled(!isValid)
                    .foregroundStyle(isValid ? AppColors.primary : AppColors.secondary)
                }
            }
            .onAppear {
                loadCurrentValues()
            }
            .onChange(of: selectedPhotoItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        imageWasRemoved = false
                    }
                }
            }
            .alert("ストックを削除", isPresented: $showingDeleteAlert) {
                Button("キャンセル", role: .cancel) { }
                Button("削除", role: .destructive) {
                    deleteStock()
                }
            } message: {
                Text("「\(stock.name)」を削除しますか？\nこの操作は取り消せません。")
            }
        }
    }
    
    // MARK: - Subviews
    
    private var currentImageData: Data? {
        if imageWasRemoved {
            return nil
        }
        return selectedImageData ?? stock.imageData
    }
    
    private var imagePickerSection: some View {
        VStack {
            if let imageData = currentImageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Button("画像を削除", role: .destructive) {
                    selectedPhotoItem = nil
                    selectedImageData = nil
                    imageWasRemoved = true
                }
                .font(.caption)
            }
            
            PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                Label(
                    currentImageData == nil ? "画像を選択" : "画像を変更",
                    systemImage: "photo"
                )
                .foregroundStyle(AppColors.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
    
    // MARK: - Actions
    
    private func loadCurrentValues() {
        name = stock.name
        quantity = stock.quantity
        memo = stock.memo
    }
    
    private func saveChanges() {
        stock.name = name.trimmingCharacters(in: .whitespaces)
        stock.quantity = quantity
        stock.memo = memo
        
        // 画像の更新
        if imageWasRemoved {
            stock.imageData = nil
        } else if let newImageData = selectedImageData {
            stock.imageData = newImageData
        }
        
        dismiss()
    }
    
    private func deleteStock() {
        modelContext.delete(stock)
        dismiss()
        onDelete?()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Stock.self, configurations: config)
    let stock = Stock(name: "トイレットペーパー", quantity: 5)
    container.mainContext.insert(stock)
    
    return EditStockView(stock: stock)
        .modelContainer(container)
}
