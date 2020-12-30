//
//  MissingNumber.swift
//  
//
//  Created by Stefan Jaindl on 04.12.20.
//

import Foundation

open class MissingNumber {
    public init() { }
    
    //Array has non-negative numbers without duplicates in the range 0 ... n, where one number is missing.
    //Runtime: ~ O(2N) = ~ O(N): checking O(N) -> O(N/2) -> O(N/4) ...
    open func findMissingNumber(of array: [Int], lenght: Int) -> Int? {
        guard !array.isEmpty, lenght == array.count else {
            return nil
        }
        
        var numbersInArray = array
        var currentBit = 0 //start with LSB
        var missingNumber = 0
        
        while currentBit < 64 {
            let counts = bitCounts(bitIndex: currentBit, zero: true, of: numbersInArray)
            
            let isZeroBit = counts.zeroes.count <= counts.ones.count
            let min = isZeroBit ? counts.zeroes : counts.ones
            
            numbersInArray = min
            if !isZeroBit {
                missingNumber |= (1 << currentBit)
            }
                
            if numbersInArray.count == 1 {
                if numbersInArray[0] == missingNumber {
                    missingNumber |= 1 << (currentBit + 1)
                }
                
                return missingNumber
            }
            
            currentBit += 1
        }
        
        return nil
    }
    
    private func bitCounts(bitIndex: Int, zero: Bool, of numbers: [Int]) -> (zeroes: [Int], ones: [Int]) {
        var zeroes: [Int] = []
        var ones: [Int] = []
        for number in numbers {
            if isBitSet(bitIndex: bitIndex, of: number) {
                ones.append(number)
            } else {
                zeroes.append(number)
            }
        }
        
        return (zeroes: zeroes, ones: ones)
    }
    
    private func isBitSet(bitIndex: Int, of number: Int) -> Bool {
        let mask = 1 << bitIndex
        return (number & mask) != 0
    }
}
