//
//  RabinKarp.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 04.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class RabinKarpSubstringSearch {
    private var base: Int
    public let hashSize: Int = 2147483647
    //A good rule of thumb is to pick both values as prime numbers with M (hashSize) as large as possible
    //so that no integer overflow occurs and "base" being at least the size of the alphabet.
    
    public init(base: Int) {
        self.base = base
    }
    
    open func substr(of sub: String, in str: String) -> Int? {
        if sub.count < 1 {
            return nil
        }
        
        if sub.count > str.count {
            return nil
        }
        
        var hashes = [Int] (repeating: -1, count: str.count - sub.count + 1)
        let stringChars = Array(str)
        
        hashes[0] = rabinFinterprint(Array(stringChars[0 ... sub.count - 1]))
        
        for index in 1 ... str.count - sub.count {
            //let compare = rabinFinterprint(Array(stringChars[index ... index + sub.count - 1]))
            hashes[index] = shiftedRabin(prevHash: hashes[index - 1], prevChar: stringChars[index - 1], newChar: stringChars[index + sub.count - 1], exp: sub.count - 1)
        }
        
        let subStrHash = rabinFinterprint(Array(sub))
        
        Hash:
        for (index, hash) in hashes.enumerated() {
            if hash == subStrHash {
                for (subIndex, char) in sub.enumerated() {
                    if stringChars[index + subIndex] != char {
                        continue Hash
                    }
                }
                return index
            }
        }
        
        return nil
    }
    
    private func rabinFinterprint(_ c: [Character]) -> Int {
        var hash = 0
        var index = 0
        
        for exp in stride(from: c.count - 1, to: -1, by: -1) {
            hash += Int(c[index].asciiValue!) * Int(pow(Double(base), Double(exp)))
            index += 1
        }
        
        hash = hash % hashSize
        
        if hash < 0 { // in case overflows occurs
            hash += hashSize;
        }
        
        return hash
    }
    
    private func shiftedRabin(prevHash: Int, prevChar: Character, newChar: Character, exp: Int) -> Int {
        let hashOfPrevChar = Int(prevChar.asciiValue!) * Int(pow(Double(base), Double(exp)))
        let leftShiftedValue = (prevHash - hashOfPrevChar) * base
        var hash = leftShiftedValue + Int(newChar.asciiValue!)
        
        hash = hash % hashSize
        
        if hash < 0 { // in case overflows occurs
            hash += hashSize;
        }
        
        return hash
    }
}
