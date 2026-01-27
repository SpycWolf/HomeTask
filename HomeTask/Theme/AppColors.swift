//
//  AppColors.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import SwiftUI

enum AppColors {
    // MARK: - Brand Colors
    static let primary = Color("AppPrimary")
    static let secondary = Color("AppSecondary")
    
    // MARK: - Background
    static let background = Color(.systemBackground)
    static let cardBackground = Color(.secondarySystemBackground)
    
    // MARK: - Text
    static let textPrimary = Color(.label)
    static let textSecondary = Color(.secondaryLabel)
    
    // MARK: - Status
    static let success = Color.green
    static let warning = Color.orange
    static let danger = Color.red
    
    // MARK: - Quantity Status Helper
    static func quantityColor(for quantity: Int) -> Color {
        switch quantity {
        case 0: return danger
        case 1...2: return warning
        default: return success
        }
    }
}
