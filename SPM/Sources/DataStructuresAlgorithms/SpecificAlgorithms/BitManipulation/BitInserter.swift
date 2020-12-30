//
//  BitInserter.swift
//  
//
//  Created by Stefan Jaindl on 23.07.20.
//

import Foundation

open class BitInserter {
    //Inserts bits of numberToInsert into baseNumber at given positions
    public init() { }
    
    open func insert(_ numberToInsert: Int, into baseNumber: Int, fromBitIndex: Int, toBitIndex: Int) -> Int {
        let cleared = clearBits(number: baseNumber, fromBitIndex: fromBitIndex, toBitIndex: toBitIndex)
        return insert(numberToInsert: numberToInsert, cleared: cleared, fromBitIndex: fromBitIndex)
    }
    
    private func clearBits(number: Int, fromBitIndex: Int, toBitIndex: Int) -> Int {
        var bitMask = -1 << (fromBitIndex + toBitIndex - 1)
        for index in 0 ..< fromBitIndex {
            bitMask |= 1 << index
        }
        
        return number & bitMask
    }
    
    private func insert(numberToInsert: Int, cleared: Int, fromBitIndex: Int) -> Int {
        return (numberToInsert << fromBitIndex) | cleared
    }
}
