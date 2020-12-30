//
//  DuplicateFinder.swift
//  
//
//  Created by Stefan Jaindl on 25.09.20.
//

import Foundation

open class DuplicateFinder {
    public init() { }
    
    static let minAllowedValue = 1
    static let maxAllowedValue = 32000
    
    open func findDuplicates(array: [Int], maxValue: Int) -> Set<Int> {
        guard !array.isEmpty, maxValue >= Self.minAllowedValue, maxValue <= Self.maxAllowedValue else {
            return []
        }
        
        var duplicates = Set<Int>()
        let bitVector = BitVector(numberOfBits: maxValue + 1) //0 bit of index 0 is unused, we need to expand bits to not risk index out of bounds
        
        for value in array {
            if bitVector.isBitSet(index: value) {
                duplicates.insert(value)
            } else {
                bitVector.setBit(index: value)
            }
        }
        
        return duplicates
    }
}
