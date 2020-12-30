//
//  ContiguousSum.swift
//  
//
//  Created by Stefan Jaindl on 28.11.20.
//

import Foundation

open class ContiguousSum {
    public init() { }
    
    open func largestContiguousSum(of array: [Int]) -> Int? {
        if array.isEmpty {
            return nil
        }
        
        var maximum = Int.min
        var trackingSum = 0
        
        array.forEach { element in
            maximum = max(maximum, element)
            trackingSum += element
            maximum = max(maximum, trackingSum)
            trackingSum = max(trackingSum, 0)
        }
        
        return maximum
    }
}
