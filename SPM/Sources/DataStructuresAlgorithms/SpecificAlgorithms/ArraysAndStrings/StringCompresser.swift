//
//  OneAwayChecker.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 15.05.20.
//

import Foundation

open class StringCompresser {
    
    public init() { }
    
    //Performs simple string compression
    open func compress(string: String) -> String {
        if string.count <= 2 {
            return string
        }
        
        let compressedStringCount = compressedCount(string: string)
        
        if compressedStringCount >= string.count {
            return string
        }
        
        var compressed: [Character] = []
        compressed.reserveCapacity(compressedStringCount)
        
        var currentCharCount = 0
        var currentChar: Character?
        
        for char in string {
            guard let current = currentChar else {
                currentChar = char
                currentCharCount += 1
                continue
            }
            
            if current == char {
                currentCharCount += 1
            } else {
                compressed.append(current)
                compressed.append(contentsOf: String(currentCharCount))
                currentChar = char
                currentCharCount = 1
            }
        }
        
        if currentCharCount > 0, let currentChar = currentChar {
            compressed.append(currentChar)
            compressed.append(contentsOf: String(currentCharCount))
        }
        
        return String(compressed)
    }
    
    func compressedCount(string: String) -> Int {
        var count = 0
        var currentChar: Character?
        for char in string {
            guard let current = currentChar else {
                count += 1
                currentChar = char
                continue
            }
            
            if char != current {
                count += 1
                currentChar = char
            }
        }
        
        return count * 2
    }
}
