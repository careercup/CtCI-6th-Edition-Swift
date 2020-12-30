//
//  DivingBoard.swift
//  
//
//  Created by Stefan Jaindl on 22.11.20.
//

import Foundation

open class DivingBoard {
    let shortPlank: Plank
    let longPlank: Plank
    
    public init(shortPlank: Plank, longPlank: Plank) {
        self.shortPlank = shortPlank
        self.longPlank = longPlank
    }
    
    open func divingBoardFast(numberOfPlanks: Int) -> [Int] {
        //O(P) = linear solution
        guard numberOfPlanks > 0 else {
            return []
        }
        
        var plankLenghts: [Int] = []
        for longPlanks in 0 ... numberOfPlanks {
            let shortPlanks = numberOfPlanks - longPlanks
            plankLenghts.append(shortPlanks * shortPlank.length + longPlanks * longPlank.length)
        }
        
        return plankLenghts
    }
    
    open func divingBoard(numberOfPlanks: Int) -> [Int] {
        // optimized solution, memoization brings O(2 ^ P) runtime down O(K^2), as we are filling K levels with max K sums each (HT)
        guard numberOfPlanks > 0 else {
            return []
        }
        
        var lengths: [PlankLength: [Int]] = [:] //lookup table for already calculated lenghts
        var results: Set<Int> = [] //Final results array
        
        _ = divingBoard(maxPlanks: numberOfPlanks, currentPlanks: 0, lenghts: &lengths, currentLenght: 0, results: &results)
        
        return results.sorted(by: { $0 < $1 })
    }
    
    private func divingBoard(maxPlanks: Int, currentPlanks: Int, lenghts: inout [PlankLength: [Int]], currentLenght: Int, results: inout Set<Int>) -> [Int] {
        if currentPlanks == maxPlanks {
            results.insert(currentLenght)
            return [currentLenght]
        }
        
        let plankLength = PlankLength(currentLength: currentLenght, currentPlanks: currentPlanks)
        if lenghts.contains(where: { $0.key == plankLength }) {
            return [] //skip element
        }
        
        var totals = divingBoard(maxPlanks: maxPlanks, currentPlanks: currentPlanks + 1, lenghts: &lenghts, currentLenght: currentLenght + shortPlank.length, results: &results)
        totals.append(contentsOf: divingBoard(maxPlanks: maxPlanks, currentPlanks: currentPlanks + 1, lenghts: &lenghts, currentLenght: currentLenght + longPlank.length, results: &results))
        
        lenghts[plankLength] = totals
        
        return totals
    }
}

public struct PlankLength: Equatable, Hashable {
    let currentLength: Int
    let currentPlanks: Int
}

public enum PlankSize {
    case short(Int)
    case long(Int)
}

public struct Plank {
    let size: PlankSize
    
    var length: Int {
        switch size {
        case .short(let len):
            return len
        case .long(let len):
            return len
        }
    }
}
