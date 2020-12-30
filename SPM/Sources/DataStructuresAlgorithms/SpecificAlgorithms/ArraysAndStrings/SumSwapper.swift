//
//  SumSwapper.swift
//  
//
//  Created by Stefan Jaindl on 30.11.20.
//

import Foundation

open class SumSwapper {
    public init() { }
    
    open func swap(first: [Int], second: [Int]) -> Swappable? {
        let firstSum = sum(of: first)
        let secondSum = sum(of: second)
        let diff = secondSum - firstSum
        
        guard diff % 2 == 0 else {
            return nil //not possible to have same sum with odd and even counts
        }
        
        let searchedSwapDiff = diff / 2
        
        let firstSet = buildSet(from: first)
        let secondSet = buildSet(from: second)
        
        for number in firstSet {
            let searched = number + searchedSwapDiff
            if secondSet.contains(where: { $0 == searched }) {
                return Swappable(first: number, second: searched)
            }
        }
        
        return nil
    }
    
    private func sum(of array: [Int]) -> Int {
        return array.reduce(0) { $0 + $1 }
    }
    
    private func buildSet(from array: [Int]) -> Set<Int> {
        var set = Set<Int>()
        array.forEach {
            set.insert($0)
        }
        
        return set
    }
}

public struct Swappable: Equatable {
    let first: Int
    let second: Int
}
