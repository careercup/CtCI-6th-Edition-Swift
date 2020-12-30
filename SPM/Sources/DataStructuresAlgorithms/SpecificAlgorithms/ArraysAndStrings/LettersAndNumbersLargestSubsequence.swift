//
//  LettersAndNumbersLargestSubsequence.swift
//  
//
//  Created by Stefan Jaindl on 05.12.20.
//

import Foundation

//Computes largest subsequence of equal numbers of letters and numbers in O(N) time
open class LettersAndNumbersLargestSubsequence {
    public init() { }
    
    open func findLargestSubSequence(of array: [String]) -> [String] {
        guard !array.isEmpty else {
            return []
        }
        
        let difference = computeDifferences(of: array)
        if let submatch = findLargestSubmatch(of: difference) {
            return Array(array[submatch.start ... submatch.end])
        }
        
        return []
        
    }
    
    private func computeDifferences(of array: [String]) -> Difference {
        var differenceArray: [Int] = []
        var zeroDifference: (start: Int, end: Int)?
        var diff = 0
        for (index, element) in array.enumerated() {
            if isNumber(element: element) {
                diff += 1
            } else {
                diff -= 1
            }
            differenceArray.append(diff)
            
            if diff == 0 {
                zeroDifference = (start: 0, end: index)
            }
        }
        
        return Difference(differences: differenceArray, largestZeroDifference: zeroDifference)
    }
    
    private func findLargestSubmatch(of difference: Difference) -> (start: Int, end: Int)? {
        var checkedDiffs: [Int: Int] = [:] //maps difference to index
        
        var biggestDiffIndices: (start: Int, end: Int)?
        var biggestDiff = 0

        if let zeroDiff = difference.largestZeroDifference {
            biggestDiffIndices = zeroDiff
            biggestDiff = zeroDiff.end - zeroDiff.start + 1
        }
        
        let differences = difference.differences
        
        for (index, diff) in differences.enumerated() {
            if let previousIndexOfDiff = checkedDiffs[diff] {
                let indexDifference = index - previousIndexOfDiff + 1
                if indexDifference > biggestDiff {
                    biggestDiff = indexDifference
                    biggestDiffIndices = (start: previousIndexOfDiff + 1, end: index)
                }
            } else {
                checkedDiffs[diff] = index
            }
        }
        
        return biggestDiffIndices
    }
    
    private func isNumber(element: String) -> Bool {
        return Int(element) != nil
    }
}

struct Difference {
    let differences: [Int]
    let largestZeroDifference: (start: Int, end: Int)?
}
