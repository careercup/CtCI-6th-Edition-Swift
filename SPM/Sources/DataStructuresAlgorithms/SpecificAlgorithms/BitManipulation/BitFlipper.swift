//
//  BitFlipper.swift
//  
//
//  Created by Stefan Jaindl on 27.07.20.
//

import Foundation

open class BitFlipper {
    public init() { }
    
    open func findLongestOneBitSequenceByFlippingMaxOneBit(input: Int) -> Int {
        var maxi = 0
        var countWithZero = 0
        var countWithoutZero = 0
        var current = input
        
        while current != 0 {
            let bit = current & 1
            if bit == 1 {
                countWithZero += 1
                countWithoutZero += 1
            } else {
                countWithZero = countWithoutZero + 1
                countWithoutZero = 0
            }
            
            maxi = max(maxi, countWithZero)
            current >>= 1
        }
        
        return maxi
    }
}
