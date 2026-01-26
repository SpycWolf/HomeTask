//
//  Item.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
