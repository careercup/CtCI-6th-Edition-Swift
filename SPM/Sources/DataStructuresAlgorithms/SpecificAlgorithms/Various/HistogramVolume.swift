//
//  HistogramVolume.swift
//  
//
//  Created by Stefan Jaindl on 18.12.20.
//

import Foundation

open class HistogramVolume {
    public init() { }
    
    open func volume(of histogram: [Int]) -> Int {
        guard !histogram.isEmpty, let highestBarIndex = highest(of: histogram, from: 0, to: histogram.count - 1) else {
            return 0
        }
        
        let lookup = createHistogramData(histogram: histogram)
        return volume(of: histogram, from: 0, to: histogram.count - 1, lookup: lookup, highestBarIndex: highestBarIndex)
    }
    
    private func volume(of histogram: [Int], from: Int, to: Int, lookup: [HistogramData], highestBarIndex: Int) -> Int {
        guard !histogram.isEmpty, to > from else {
            return 0
        }
        
        var leftVolume = 0
        if highestBarIndex > 0 {
            let highestBarLeftIndex = lookup[highestBarIndex - 1].nextHighestLeftIndex
            if highestBarLeftIndex != highestBarIndex, highestBarLeftIndex >= from {
                let maxHeight = histogram[highestBarLeftIndex]
                for index in highestBarLeftIndex + 1 ..< highestBarIndex {
                    leftVolume += maxHeight - histogram[index]
                }
                
                leftVolume += volume(of: histogram, from: from, to: highestBarLeftIndex, lookup: lookup, highestBarIndex: highestBarLeftIndex)
            }
        }
       
        var rightVolume = 0
        if highestBarIndex < histogram.count - 1 {
            let highestBarRightIndex = lookup[highestBarIndex + 1].nextHighestRightIndex
            if highestBarRightIndex != highestBarIndex, highestBarRightIndex <= to {
                let maxHeight = histogram[highestBarRightIndex]
                for index in highestBarIndex + 1 ..< highestBarRightIndex {
                    rightVolume += maxHeight - histogram[index]
                }
                
                rightVolume += volume(of: histogram, from: highestBarRightIndex, to: to, lookup: lookup, highestBarIndex: highestBarRightIndex)
            }
        }
        
        return leftVolume + rightVolume
    }
    
    private func highest(of histogram: [Int], from: Int, to: Int) -> Int? {
        guard to > from else {
            return nil
        }
        
        var max = 0
        var maxIndex = from
        for index in from ... to {
            let level = histogram[index]
            if level > max {
                max = level
                maxIndex = index
            }
        }
        
        return maxIndex
    }
    
    //Lookup table bringing runtime down from O(n^2) to O(n), needing O(n) space
    private func createHistogramData(histogram: [Int]) -> [HistogramData] {
        guard !histogram.isEmpty else {
            return []
        }
        
        var histogramDataArray: [HistogramData] = []
        
        //Save tallest left indices on right sweep (array lookup)
        var currentHighestIndexOnLeft = 0
        for (index, value) in histogram.enumerated() {
            currentHighestIndexOnLeft = value > histogram[currentHighestIndexOnLeft] ? index : currentHighestIndexOnLeft
            histogramDataArray.append(HistogramData(index: index, nextHighestLeftIndex: currentHighestIndexOnLeft))
        }
        
        //Save tallest right indices on left sweep (array lookup)
        var index = histogram.count - 1
        var currentHighestIndexOnRight = index
        while index >= 0 {
            currentHighestIndexOnRight = histogram[index] > histogram[currentHighestIndexOnRight] ? index : currentHighestIndexOnRight
            let histogramData = histogramDataArray[index]
            histogramData.nextHighestRightIndex = currentHighestIndexOnRight
            
            index -= 1
        }
        
        return histogramDataArray
    }
}

private class HistogramData {
    let index: Int
    var nextHighestLeftIndex: Int
    var nextHighestRightIndex: Int
    
    init(index: Int, nextHighestLeftIndex: Int? = nil, nextHighestRightIndex: Int? = nil) {
        self.index = index
        self.nextHighestLeftIndex = nextHighestLeftIndex ?? index
        self.nextHighestRightIndex = nextHighestRightIndex ?? index
    }
}
