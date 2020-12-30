//
//  ArrayPairsWithSum.swift
//  
//
//  Created by Stefan Jaindl on 01.12.20.
//

import Foundation

open class ArrayPairsWithSum {
    public init() { }
    
    open func pairsWithSum(array: [Int], targetSum: Int) -> Set<TargetSumPair> {
        guard array.count > 1 else {
            return []
        }
        
        var lookupTable = Set<Int>()
        
        var pairs = Set<TargetSumPair>()
        
        array.forEach { element in
            let diffToTarget = targetSum - element
            if lookupTable.contains(where: { $0 == diffToTarget }) {
                pairs.insert(TargetSumPair(first: diffToTarget, second: element))
            }
            
            lookupTable.insert(element)
        }
        
        return pairs
    }
    
    public struct TargetSumPair: Hashable {
        let first: Int
        let second: Int
    }
}
