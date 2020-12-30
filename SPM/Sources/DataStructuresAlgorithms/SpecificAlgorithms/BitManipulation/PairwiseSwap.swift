//
//  PairwiseSwap.swift
//  
//
//  Created by Stefan Jaindl on 03.08.20.
//

import Foundation

open class PairwiseSwap {
    public init() { }
    
    private let oddMask = 0x5555
    private let evenMask = 0xAAAA
    
    open func swapOddEven(number: Int) -> Int {
        return (number >> 1 & oddMask) | (number << 1 & evenMask)
    }
}
