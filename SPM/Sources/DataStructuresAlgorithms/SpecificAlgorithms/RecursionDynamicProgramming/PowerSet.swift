//
//  PowerSet.swift
//  
//
//  Created by Stefan Jaindl on 15.08.20.
//

import Foundation

open class PowerSet<T: Hashable> {
    
    public init () { }
    
    //O(n*n!) = nr. of elements (n) * nr. of subsets (n!)
    open func powerSetPermutations(set: [T]) -> [[T]] {
        var result: [[T]] = []
        var lastResultSet: [[T]] = []
        
        result.append([]) //empty set
        
        for value in set {
            lastResultSet.append([value]) //level 1
        }
        
        result.append(contentsOf: lastResultSet)
        
        var level = 2
        
        while level <= set.count {
            var currentLevelSet: [[T]] = []
            for subset in lastResultSet {
                for value in set {
                    if !subset.contains(value) {
                        var element = subset
                        element.append(value)
                        currentLevelSet.append(element)
                    }
                }
            }
            
            level += 1
            result.append(contentsOf: currentLevelSet)
            lastResultSet = currentLevelSet
        }
        
        return result
    }
    
    //O(n*2^n) = nr. of elements (n) * nr. of subsets (2^n)
    open func powerSetCombinations(set: [T]) -> [[T]] {
        var result: [[T]] = []
        result.insert([], at: 0)
        
        for value in set {
            var newSet: [[T]] = []
            for subset in result {
                var newSubset = subset
                newSubset.append(value)
                newSet.append(newSubset)
            }
            result.append(contentsOf: newSet)
        }
        
        return result
    }
    
    //O(n*2^n) = nr. of elements (n) * nr. of subsets (2^n)
    open func powerSetCombinationsByBitMasking(set: [T]) -> [[T]] {
        var result: [[T]] = []
        
        let maxValue = 1 << set.count
        for value in 0 ..< maxValue {
            result.append(convertIntToSubset(value: value, set: set))
        }
        
        return result
    }
    
    private func convertIntToSubset(value: Int, set: [T]) -> [T] {
        var index = 0
        var valueToConvert = value
        var subset: [T] = []
        
        while valueToConvert > 0 {
            if valueToConvert & 1 == 1 {
                subset.append(set[index])
            }
            
            valueToConvert >>= 1
            index += 1
        }
        
        return subset
    }
}
