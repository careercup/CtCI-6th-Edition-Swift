//
//  SmallestDifference.swift
//  
//
//  Created by Stefan Jaindl on 17.11.20.
//

import Foundation

open class SmallestDifference {
    public init() { }
    
    open func smallestDifference(first: [Int], second: [Int]) -> Int? {
        guard !first.isEmpty, !second.isEmpty else {
            return nil
        }
        
        let firstSorted = first.sorted(by: { $0 < $1 } )
        let secondSorted = second.sorted(by: { $0 < $1 } )
        
        var firstIndex = 0
        var secondIndex = 0
        var smallestDifference = Int.max
        
        while firstIndex < firstSorted.count, secondIndex < secondSorted.count {
            let difference = firstSorted[firstIndex] - secondSorted[secondIndex]
            
            if difference >= 0, difference < smallestDifference {
                smallestDifference = difference
            }
            
            if firstSorted[firstIndex] < secondSorted[secondIndex] {
                firstIndex += 1
            } else {
                secondIndex += 1
            }
        }
        
        return smallestDifference
    }
}
