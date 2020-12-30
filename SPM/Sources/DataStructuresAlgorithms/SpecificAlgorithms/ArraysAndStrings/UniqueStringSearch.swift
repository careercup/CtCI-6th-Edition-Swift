//
//  UniqueStringSearch.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 03.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class UniqueStringSearch {
    
    private let alphabetSize: Int
    
    public init(alphabetSize: Int) {
        self.alphabetSize = alphabetSize
    }
    
    //V1: HashTable/Set
    open func isUniqueStringWithHash(input: String) -> Bool {
        if input.count > alphabetSize {
            return false
        }
        
        var charSet = Set<Character>()
        
        for char in Array(input) {
            if charSet.contains(char) {
                return false
            }
            
            charSet.insert(char)
        }
        
        return true
    }
    
    //V2: BitVector
    open func isUniqueStringWithBitVector(input: String) -> Bool {
        if input.count > alphabetSize {
            return false
        }
        
        let bitVector = BitVector(numberOfBits: alphabetSize)
        
        for char in Array(input) {
            guard let ascii = char.asciiValue else {
                continue
            }
            
            if bitVector.isBitSet(index: Int(ascii)) {
                return false
            }
            
            bitVector.setBit(index: Int(ascii))
        }
        
        return true
    }
    
    //V3: Without additional datastructures
    open func isUniqueStringWithSorting(input: String) -> Bool {
        if input.count > alphabetSize {
            return false
        }
        
        let sorted = input.sorted()
        var char: Character?
        
        for curChar in Array(sorted) {
            if let char = char, curChar == char {
                return false
            }
            char = curChar
        }
        
        return true
    }
}
