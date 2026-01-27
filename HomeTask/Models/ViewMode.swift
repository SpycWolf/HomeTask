//
//  ViewMode.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import Foundation

enum ViewMode: String, CaseIterable {
    case list = "list"
    case grid = "grid"
    
    var icon: String {
        switch self {
        case .list: return "list.bullet"
        case .grid: return "square.grid.2x2"
        }
    }
}
