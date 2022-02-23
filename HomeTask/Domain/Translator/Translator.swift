//
//  Translator.swift
//  HomeTask
//
//  Created by spycwolf on 2022/02/15.
//

import Foundation

protocol Translator {
    associatedtype Input
    associatedtype Output
    
    func translate(_: Input) -> Output
}
