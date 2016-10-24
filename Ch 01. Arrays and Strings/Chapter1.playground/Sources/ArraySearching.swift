//
//  ArraySearching.swift
//
//
//  Created by Matthew Carroll on 10/13/16.
//  Copyright © 2016 Third Cup lc. All rights reserved.
//

import Foundation

//: Similar to EnumerateGenerator, but returns the index of the elment instead of an Int
public extension Collection where Indices.Iterator.Element == Index {
    
    func enumeratedIndices() -> Zip2Sequence<Indices, Self> {
        return zip(indices, self)
    }
}

extension Zip2Iterator: Sequence {
    
    public func makeIterator() -> Zip2Iterator<Iterator1, Iterator2> {
        return self
    }
}

public extension Collection {
    
    func enumeratedPairs() -> Zip2Sequence<Zip2Iterator<Indices.Iterator, Iterator>, Zip2Iterator<Indices.Iterator, Iterator>> {
        let left = zip(indices, self).makeIterator()
        var right = left
        _ = right.next()
        return zip(left, right)
    }
}

public extension Collection where Indices.Iterator.Element == Index {
    
    typealias EnumeratedPair = (leftIndex: Index, leftElement: Iterator.Element, rightIndex: Index, rightElement: Iterator.Element)
    
    func successiveElements(where predicate: (_ left: Iterator.Element, _ right: Iterator.Element) -> Bool) -> EnumeratedPair? {
        for ((leftI, left), (rightI, right)) in enumeratedPairs() {
            guard predicate(left, right) else { continue }
            return (leftI, left, rightI, right)
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
