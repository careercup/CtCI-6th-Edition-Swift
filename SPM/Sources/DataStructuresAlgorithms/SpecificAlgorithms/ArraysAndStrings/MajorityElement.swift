//
//  MajorityElement.swift
//  
//
//  Created by Stefan Jaindl on 08.12.20.
//

import Foundation

open class MajorityElement {
    public init() { }
    
    private let minSubarrayElementsToCheck = 2
    private let matchPercentageTreshold = 0.5
    
    open func find(array: [Int]) -> Int? {
        var index = 0
        while index < array.count {
            if let matched = checkSubarray(array: array, startIndex: index) {
                return matched
            }
            
            index += 2
        }
        
        return nil
    }
    
    private func checkSubarray(array: [Int], startIndex: Int) -> Int? {
        var matches = 0
        var checked = 0
        var index = startIndex
        
        let elementToMatch = array[index]
        
        while checked < minSubarrayElementsToCheck || Double(Double(matches) / Double(checked)) > matchPercentageTreshold {
            if index == startIndex && matches > 0 {
                //found majority element!
                return elementToMatch
            }
            
            if array[index] == elementToMatch {
                matches += 1
            }
            
            index = (index + 1) % array.count
            checked += 1
        }
        
        return nil
    }
}
