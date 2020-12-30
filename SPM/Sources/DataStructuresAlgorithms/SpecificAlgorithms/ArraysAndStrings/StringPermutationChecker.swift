//
//  StringPermuationChecker.swift
//  
//
//  Created by Stefan Jaindl on 09.05.20.
//

import Foundation

open class StringPermuationChecker {
    private let alphabetSize: Int
    
    init(alphabetSize: Int) {
        self.alphabetSize = alphabetSize
    }
    
    open func isPermutationOfByCharArray(first: String, second: String) -> Bool {
        if first.count != second.count {
            //Permutations must have same size
            return false
        }
        
        //Check for same character count:
        var array = [Int] (repeating: 0, count: alphabetSize)
        for char in Array(first) {
            guard let ascii = char.asciiValue else {
                return false
            }
            
            array[Int(ascii)] += 1
        }
        
        for char in Array(second) {
            guard let ascii = char.asciiValue else {
                return false
            }
            
            array[Int(ascii)] -= 1
            if array[Int(ascii)] < 0 {
                return false
            }
        }
        
        return true
    }
    
    open func isPermutationOfBySorting(first: String, second: String) -> Bool {
        if first.count != second.count {
            //Permutations must have same size
            return false
        }
        
        //Sort strings
        let firstSorted = first.sorted()
        let secondSorted = second.sorted()
        
        return firstSorted == secondSorted
    }
}
