//
//  Rand7.swift
//  
//
//  Created by Stefan Jaindl on 01.12.20.
//

import Foundation

open class Rand7 {
    open func random() -> Int {
        var random = Int.max
        
        while random >= 21 {
            random = rand5() * 5 + rand5()
        }
        
        return random % 7
    }
    
    private func rand5() -> Int {
        return Int.random(in: 0 ..< 5)
    }
}


