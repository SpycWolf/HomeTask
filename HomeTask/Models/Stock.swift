//
//  Stock.swift
//  HomeTask
//
//  Created by Kaneko Kota on 2026/01/27.
//

import Foundation
import SwiftData

@Model
final class Stock {
    var name: String
    var quantity: Int
    @Attribute(.externalStorage)
    var imageData: Data?
    var memo: String
    
    init(
        name: String,
        quantity: Int = 0,
        imageData: Data? = nil,
        memo: String = ""
    ) {
        self.name = name
        self.quantity = quantity
        self.imageData = imageData
        self.memo = memo
    }
}
