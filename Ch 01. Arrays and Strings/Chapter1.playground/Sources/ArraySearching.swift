//
//  ArraySearching.swift
//
//
//  Created by Matthew Carroll on 10/13/16.
//  Copyright © 2016 Third Cup lc. All rights reserved.
//

import Foundation

public extension Collection where Indices.Iterator.Element == Index {
    
    typealias ComparisonResult = (leftIndex: Index, leftElement: Iterator.Element, rightIndex: Index, rightElement: Iterator.Element)
    
    func successiveElements(where predicate: (_ previousElement: Iterator.Element, _ element: Iterator.Element) -> Bool) -> ComparisonResult? {
        for (i, x) in enumeratedIndices().dropFirst() {
            let prevI = index(i, offsetBy: -1)
            let previousElement = self[prevI]
            if predicate(previousElement, x) {
                return (prevI, previousElement, i, x)
            }
        }
        return nil
    }
}

public extension Collection where Indices.Iterator.Element == Index {
    
    func unsortedRange(isUnordered: (_ left: Iterator.Element, _ right: Iterator.Element) -> Bool) -> ClosedRange<Index>? {
        guard let unsortedStart = successiveElements(where: isUnordered) else { return nil }
        
        var unsortedEnd = unsortedStart.leftIndex
        var unsortedMax = unsortedStart.leftElement
        let d = distance(from: startIndex, to: unsortedStart.rightIndex)
        
        for (i, x) in enumeratedIndices().dropFirst(numericCast(d)) {
            if isUnordered(unsortedMax, x) {
                unsortedEnd = i
            }
            else {
                unsortedMax = x
            }
        }
        return unsortedStart.leftIndex...unsortedEnd
    }
}

public extension Collection {
    
    func groupBy<Key>(f: (Iterator.Element) -> Key) -> [Key: [Iterator.Element]] {
        var groups: [Key: [Iterator.Element]] = [:]
        for x in self {
            let key = f(x)
            var array = groups[key] ?? []
            array.append(x)
            groups[key] = array
        }
        return groups
    }
}
