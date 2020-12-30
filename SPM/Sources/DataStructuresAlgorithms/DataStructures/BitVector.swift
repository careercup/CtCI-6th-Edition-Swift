//
//  BitVector.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 03.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class BitVector {
    private let numberOfBits: Int
    private var bitStorage: [UInt64]
    private let base = 64
    
    public init(numberOfBits: Int) {
        self.numberOfBits = numberOfBits
        
        //storage has place for 64 bits per UInt64 array entry. Round up.
        let arraySize = (numberOfBits + base - 1) / base
        bitStorage = [UInt64] (repeating: 0, count: arraySize)
    }
    
    open func setBit(index: Int) {
        let arrayIndex = index / base
        let bitIndex = index % base
        let bit: UInt64 = 1 << bitIndex
        
        bitStorage[arrayIndex] |= bit
    }
    
    open func unsetBit(index: Int) {
        let arrayIndex = index / base
        let bitIndex = index % base
        let bit: UInt64 = ~(1 << bitIndex)
        
        bitStorage[arrayIndex] &= bit
    }
    
    open func isBitSet(index: Int) -> Bool {
        let arrayIndex = index / base
        let bitIndex = index % base
        let bit: UInt64 = 1 << bitIndex
        
        return bitStorage[arrayIndex] & bit > 0
    }
}
