//
//  Translator.swift
//  HomeTask
//
//  Created by 金子宏太 on 2022/02/15.
//

import Foundation

protocol Translator {
    associatedtype Input
    associatedtype Output
    
    func translate(_: Input) -> Output
}
