//
//  StockViewModel.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/14.
//

import Foundation
import CoreData
import SwiftUI

class StockViewModel: ObservableObject {
    private let useCase: StockUseCase = StockUseCaseImpl(repository: StockRepositoryImpl())
    
    @Published private(set) var stocks: [StockModel] = []
    
    func onAppear() {
        stocks = useCase.stocks()
    }
    
    func increment() {
        print("called increment")
    }
    
    func decrement() {
        print("called decrement")
    }
    
    func addBag() {
        print("called addBag")
    }
}
