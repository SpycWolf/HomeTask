//
//  StockViewModel.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/14.
//

import Foundation

class StockViewModel: ObservableObject {
    @Published private(set) var stocks: [Stock] = []
    
    func onAppear() {
        stocks = Stock.sample()
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
