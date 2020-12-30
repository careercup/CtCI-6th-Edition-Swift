//
//  CircusTower.swift
//  
//
//  Created by Stefan Jaindl on 06.12.20.
//

import Foundation

open class CircusTower {
    public init() { }
    
    open func highestTowerSize(of people: [CircusPeople]) -> Int {
        guard !people.isEmpty else {
            return 0
        }
        
        let sorted = people.sorted(by: { $0.height < $1.height })
        var lookup: [CircusPeople: Int] = [:]
        
        return towerSize(of: sorted, minWidth: -1, minHeight: -1, countSoFar: 0, lookup: &lookup)
    }
    
    private func towerSize(of people: [CircusPeople], minWidth: Double, minHeight: Double, countSoFar: Int, lookup: inout [CircusPeople: Int]) -> Int {
        if people.isEmpty {
            return countSoFar
        }
        
        var maxCount = countSoFar
        for (index, guy) in people.enumerated() {
            if guy.height > minHeight, guy.width > minWidth {
                if let count = lookup[guy] {
                    maxCount = max(maxCount, countSoFar + count)
                } else {
                    let subCount = towerSize(of: Array(people[index + 1 ..< people.count]), minWidth: guy.width, minHeight: guy.height, countSoFar: countSoFar + 1, lookup: &lookup)
                    maxCount = max(maxCount, subCount)
                    lookup[guy] = subCount - countSoFar
                }
            }
        }
        
        return maxCount
    }
}

public struct CircusPeople: Hashable {
    let width: Double
    let height: Double
}
