//
//  StackOfBoxes.swift
//  
//
//  Created by Stefan Jaindl on 26.08.20.
//

import Foundation

open class StackOfBoxes {
    
    public init() { }
    
    open func maxHeight(of stack: [Box]) -> Int {
        if stack.isEmpty {
            return 0
        }
        
        let sorted = stack.sorted(by: >)
        var maxHeight = 0
        
        for (index, box) in sorted.enumerated() {
            if box.height > maxHeight {
                maxHeight = box.height
            }
            
            for previous in 0 ..< index {
                if isValid(first: box, second: sorted[previous]) && sorted[previous].maxHeight + box.height > box.maxHeight {
                    box.maxHeight = box.height + sorted[previous].maxHeight
                    
                    maxHeight = max(maxHeight, box.maxHeight)
                }
            }
        }
        
        return maxHeight
    }
    
    private func isValid(first: Box, second: Box) -> Bool {
        return first.width < second.width && first.height < second.height && first.depth < second.depth
    }
}

open class Box: Equatable, Comparable {
    public let width: Int
    public let height: Int
    public let depth: Int
    
    public var maxHeight: Int
    
    public init(width: Int, height: Int, depth: Int) {
        self.width = width
        self.height = height
        self.depth = depth
        
        maxHeight = height //max height together with other boxes is at least == height of the box itself
    }
    
    public static func < (lhs: Box, rhs: Box) -> Bool {
        return lhs.height < rhs.height
    }
    
    public static func == (lhs: Box, rhs: Box) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height && lhs.depth == rhs.depth
    }
}
