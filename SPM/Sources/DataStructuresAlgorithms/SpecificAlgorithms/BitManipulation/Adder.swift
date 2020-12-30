//
//  Adder.swift
//  
//
//  Created by Stefan Jaindl on 03.12.20.
//

import Foundation

open class Adder {
    public init() { }
    
    open func addWithoutPlus(first: Int, second: Int) -> Int {
        var currentFirst = first
        var currentSecond = second
        var shiftIndex = 0
        var result = 0
        var carry = 0
        
        while currentFirst != 0 || currentSecond != 0 || carry != 0 {
            let firstDigit = currentFirst & 1
            let secondDigit = currentSecond & 1
            var bit = firstDigit ^ secondDigit
            if carry == 1 {
                bit = bit == 1 ? 0 : 1
            }
            
            carry = firstDigit & secondDigit == 1 || carry > 0 && firstDigit | secondDigit > 0 ? 1 : 0
            result |= (bit << shiftIndex)
            currentFirst >>= 1
            currentSecond >>= 1
            shiftIndex = incrementByOne(bit: shiftIndex)
        }
        
        return result
    }
    
    open func incrementByOne(bit: Int) -> Int {
        //1. Find rightmost 0 bit & Toggle all trailing 1's to 0 (right of index)
        //2. toggle index place to 1
        let zeroIndex = rightmostZeroIndex(of: bit)
        let temp = setRangeToZero(bit: bit, at: zeroIndex)
        return setBitToOne(of: temp, until: zeroIndex)
    }
    
    private func rightmostZeroIndex(of bit: Int) -> Int {
        var index = 0
        var shiftedBit = bit
        
        while shiftedBit & 1 != 0 {
            shiftedBit >>= 1
            index += 1
        }
        
        return index
    }
    
    private func setRangeToZero(bit: Int, at index: Int) -> Int {
        //mask format: e.g.: 111111111111111111111111111111111111111111111111111111111111100 (for index 2)
        let mask = Int.max & ((Int.max >> index) << index)
        
        return bit & mask
        
        //alternative: let mask = (1 << index) - 1; return bit ^ mask
    }
    
    private func setBitToOne(of bit: Int, until index: Int) -> Int {
        //mask format: e.g.: 100  (for index 2)
        let mask = 1 << index
        
        return bit | mask
    }
}
