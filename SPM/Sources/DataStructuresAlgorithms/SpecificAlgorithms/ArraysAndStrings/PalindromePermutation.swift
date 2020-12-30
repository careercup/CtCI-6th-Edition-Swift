//
//  PalindromePermutation.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 14.05.20.
//

import Foundation

open class PalindromePermutation {
    private let alphabetSize: Int
    
    public init(alphabetSize: Int) {
        self.alphabetSize = alphabetSize
    }
    
    open func isPalindromePermutation(input: String) -> Bool {
        if input.count < 2 {
            return true
        }
        
        var oddCounter = 0
        let bitVector = BitVector(numberOfBits: alphabetSize)
        
        for char in input {
            guard let asciiValue = char.asciiValue else {
                continue //disregard non ASCII chars..
            }
            
            if bitVector.isBitSet(index: Int(asciiValue)) {
                bitVector.unsetBit(index: Int(asciiValue))
                oddCounter -= 1
            } else {
                bitVector.setBit(index: Int(asciiValue))
                oddCounter += 1
            }
        }
        
        if oddCounter <= 1 {
            //For odd strings there must be exactly 1 odd char (center char) and for even strings no odd char
            return true
        }
        
        //Alternative with bit manipulation - It's a palindrome permuation, if:
        //1. no bit is set (= no unique chars)  --> bitvector Int == 0
        //2. or not more than 1 bit is set (middle one for odd strings) --> bitVector Int at pos - 1. pos - 1 & pos
        
        return false
    }
}
