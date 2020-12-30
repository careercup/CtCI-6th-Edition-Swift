//
//  WordDistance.swift
//  
//
//  Created by Stefan Jaindl on 09.12.20.
//

import Foundation

open class WordDistance {
    
    var indexDict: [String: [Int]] = [:]
    
    public init(words: [String]) {
        preprocess(words: words)
    }
    
    private func preprocess(words: [String]) {
        for (index, word) in words.enumerated() {
            if var indices = indexDict[word] {
                indices.append(index)
                indexDict[word] = indices
            } else {
                indexDict[word] = [index]
            }
        }
    }
    
    open func distance(first: String, second: String) -> Int? {
        guard let firstIndices = indexDict[first], let secondIndices = indexDict[second] else {
            return nil
        }
        
        var firstIndex = 0
        var secondIndex = 0
        var minDistance = Int.max
        while firstIndex < firstIndices.count, secondIndex < secondIndices.count {
            minDistance = min(minDistance, abs(firstIndices[firstIndex] - secondIndices[secondIndex]))
            if firstIndices[firstIndex] < secondIndices[secondIndex] {
                firstIndex += 1
            } else {
                secondIndex += 1
            }
        }
        
        return minDistance
    }
}
