//
//  ShortestSuperSequence.swift
//  
//
//  Created by Stefan Jaindl on 12.12.20.
//

import Foundation

open class ShortestSuperSequence<T: Comparable & Hashable> {
    public init() { }
    
    open func findShortestSuperSequence(of smaller: [T], in bigger: [T]) -> SuperSequenceIndexPair? {
        guard !smaller.isEmpty, !bigger.isEmpty, smaller.count < bigger.count else {
            return nil
        }
        
        let searchedCounts = buildSearchedTable(of: smaller)
        
        //Search in increasing slider ranges:
        for arraySearchRange in smaller.count ... bigger.count {
            var runningCounts = buildRunningCounts(of: bigger, with: searchedCounts, range: arraySearchRange, elementCount: smaller.count)
            if runningCounts.matches {
                return SuperSequenceIndexPair(start: 0, end: arraySearchRange - 1)
            }
            
            //Iterate through array in current range:
            for index in 0 ..< bigger.count - arraySearchRange {
                let nextToBeRemoved = bigger[index]
                let nextToBeAdded = bigger[index + arraySearchRange]
                
                updateRunningCounts(add: nextToBeAdded, remove: nextToBeRemoved, runningCounts: &runningCounts)
                if runningCounts.matches {
                    return SuperSequenceIndexPair(start: index + 1, end: index + arraySearchRange)
                }
            }
        }
        
        return nil
    }
    
    private func updateRunningCounts(add: T, remove: T, runningCounts: inout SequenceResult<T>) {
        let removedMatching = addOrChangeExisting(table: &runningCounts.counts, element: remove, changeValue: 1) >= 0
        let addedMatching = addOrChangeExisting(table: &runningCounts.counts, element: add, changeValue: -1) >= 0
        
        if removedMatching {
            runningCounts.diffToTarget += 1
        }
        
        if addedMatching {
            runningCounts.diffToTarget -= 1
        }
    }
    
    private func buildSearchedTable(of array: [T]) -> [T: Int] {
        //building table: value -> count
        var table: [T: Int] = [:]
        for element in array {
            addOrIncrease(table: &table, element: element, increaseValue: 1)
        }
        
        return table
    }
    
    private func addOrChangeExisting(table: inout [T: Int], element: T, changeValue: Int) -> Int {
        if let count = table[element] {
            table[element] = count + changeValue
            return count + changeValue
        }
        
        return -1
    }
    
    private func addOrIncrease(table: inout [T: Int], element: T, increaseValue: Int) {
        if let count = table[element] {
            table[element] = count + increaseValue
        } else {
            table[element] = increaseValue
        }
    }
    
    private func buildRunningCounts(of array: [T], with searched: [T: Int], range: Int, elementCount: Int) -> SequenceResult<T> {
        var diffToTarget = elementCount
        var counts = searched
        
        for curIndex in 0 ..< range {
            let curElement = array[curIndex]
            if let matched = searched[curElement] {
                counts[curElement] = matched - 1
                diffToTarget = max(0, diffToTarget - 1)
            }
        }
        
        return SequenceResult(counts: counts, diffToTarget: diffToTarget)
    }
}

public struct SuperSequenceIndexPair: Equatable {
    let start: Int
    let end: Int
}

open class SequenceResult<T: Comparable & Hashable> {
    var counts: [T: Int]
    var diffToTarget: Int
    
    init(counts: [T: Int], diffToTarget: Int) {
        self.counts = counts
        self.diffToTarget = diffToTarget
    }
    
    var matches: Bool {
        return diffToTarget == 0
    }
}
