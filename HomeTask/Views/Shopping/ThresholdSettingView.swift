//
//  ThresholdSettingView.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI

struct ThresholdSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("shoppingThreshold") private var threshold: Int = 2
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Text("以下の個数以下を抽出")
                    .font(.headline)
                    .foregroundStyle(AppColors.textSecondary)
                
                HStack(spacing: 24) {
                    Button {
                        if threshold > 0 {
                            threshold -= 1
                        }
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(threshold > 0 ? AppColors.primary : AppColors.secondary.opacity(0.5))
                    }
                    .disabled(threshold <= 0)
                    
                    Text("\(threshold)")
                        .font(.system(size: 56, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)
                        .frame(minWidth: 80)
                    
                    Button {
                        if threshold < 99 {
                            threshold += 1
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(AppColors.primary)
                    }
                    .disabled(threshold >= 99)
                }
                
                Text("個")
                    .font(.title2)
                    .foregroundStyle(AppColors.textSecondary)
            }
            .padding()
            .navigationTitle("抽出設定")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完了") {
                        dismiss()
                    }
                    .foregroundStyle(AppColors.primary)
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    ThresholdSettingView()
}
