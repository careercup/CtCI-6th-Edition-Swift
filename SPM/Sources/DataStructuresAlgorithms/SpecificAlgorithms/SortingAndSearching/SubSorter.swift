//
//  SubSorter.swift
//  
//
//  Created by Stefan Jaindl on 28.11.20.
//

import Foundation

open class SubSorter {
    public init() { }
    
    open func shortestSubsortRange(of array: [Int]) -> SortRange? {
        if array.count <= 1 {
            return nil
        }
        
        var leftSequenceIndex = 0
        var rightSequenceIndex = array.count - 1
        var leftValue = Int.min
        var rightValue = Int.max
        
        //find longest sorted sequence from left
        while leftSequenceIndex < array.count, array[leftSequenceIndex] > leftValue {
            leftValue = array[leftSequenceIndex]
            leftSequenceIndex += 1
        }
        if leftSequenceIndex > 0 {
            leftSequenceIndex -= 1 //reset to last valid pos
        }
        
        //find longest sorted sequence from right
        while rightSequenceIndex >= 0, array[rightSequenceIndex] < rightValue {
            rightValue = array[rightSequenceIndex]
            rightSequenceIndex -= 1
        }
        if rightSequenceIndex < array.count - 1 {
            rightSequenceIndex += 1 //reset to last valid pos
        }
        
        if rightSequenceIndex <= leftSequenceIndex {
            return nil //already sorted
        }
        
        //center elements are definitely included in subsort
        if rightSequenceIndex - leftSequenceIndex > 0 {
            //Find min and max center elements and move sequence indices back to some point, if necessary
            let (min, max) = minMax(of: array, from: leftSequenceIndex, to: rightSequenceIndex)
            
            leftSequenceIndex = shiftLeft(array: array, index: leftSequenceIndex, to: min)
            rightSequenceIndex = shiftRight(array: array, index: rightSequenceIndex, to: max)
        }
        
        return SortRange(from: leftSequenceIndex, to: rightSequenceIndex)
    }
    
    private func minMax(of array: [Int], from: Int, to: Int) -> (min: Int, max: Int) {
        var minimum = Int.max
        var maximum = Int.min
        
        for index in from ... to {
            minimum = min(array[index], minimum)
            maximum = max(array[index], maximum)
        }
        
        return (min: minimum, max: maximum)
    }
    
    private func shiftLeft(array: [Int], index: Int, to value: Int) -> Int {
        var newIndex = index
        while newIndex >= 0, array[newIndex] > value {
            newIndex -= 1
        }
        
        if newIndex != index {
            newIndex += 1 //set to last valid pos
        }
        
        return newIndex
    }
    
    private func shiftRight(array: [Int], index: Int, to value: Int) -> Int {
        var newIndex = index
        while newIndex < array.count, array[newIndex] < value {
            newIndex += 1
        }
        
        if newIndex != index {
            newIndex -= 1 //set to last valid pos
        }
        
        return newIndex
    }
}

public struct SortRange: Equatable {
    let from: Int
    let to: Int
}
