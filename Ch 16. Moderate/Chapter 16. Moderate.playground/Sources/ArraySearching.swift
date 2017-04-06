//
//  BinarySearch.swift
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
        let _ = right.next()
        return zip(left, right)
    }
}

public extension Collection where Indices.Iterator.Element == Index {
    
    typealias EnumeratedPair = (leftIndex: Index, leftElement: Iterator.Element, rightIndex: Index, rightElement: Iterator.Element)
    
    func successiveElements(where predicate: (_ previousElement: Iterator.Element, _ element: Iterator.Element) -> Bool) -> EnumeratedPair? {
        for (left, right) in enumeratedPairs() {
            guard predicate(left.1, right.1) else { continue }
            return (left.0, left.1, right.0, right.1)
        }
        return nil
    }
    
    func successiveElements2(where predicate: (_ previousElement: Iterator.Element, _ element: Iterator.Element) -> Bool) -> EnumeratedPair? {
        var i = startIndex
        var k = index(after: i)
        while k < endIndex {
            let left = self[i]
            let right = self[k]
            guard predicate(left, right) else {
                i = k
                k = index(after: k)
                continue
            }
            return(i, left, k, right)
        }
        return nil 
    }

}

public extension Collection where Indices.Iterator.Element == Index, Index: Strideable, Index: SignedInteger {
    
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
    
    func groupBy<Key>(key: (Iterator.Element) -> Key) -> [Key: [Iterator.Element]] {
        var groups: [Key: [Iterator.Element]] = [:]
        for x in self {
            let key = key(x)
            var array = groups[key] ?? []
            array.append(x)
            groups[key] = array
        }
        return groups
    }
}

public extension Collection where Iterator.Element: Comparable, SubSequence.Iterator.Element == Iterator.Element, SubSequence: Collection, SubSequence.Indices.Iterator.Element == Index, SubSequence.Index == Index {
    
    func maxElementIndex() -> Index? {
        guard !self.isEmpty else { return nil }
        var prev = self[startIndex]
        var maxI = startIndex
        for (i, x) in dropFirst().enumeratedIndices() {
            if x > prev {
                prev = x
                maxI = i
            }
        }
        return maxI
    }
}

public extension Collection where Iterator.Element: Comparable, SubSequence.Iterator.Element == Iterator.Element, SubSequence: Collection, SubSequence.Indices.Iterator.Element == Index, SubSequence.Index == Index {
    
    func minElementIndex() -> Index? {
        guard !self.isEmpty else { return nil }
        var prev = self[startIndex]
        var minI = startIndex
        for (i, x) in dropFirst().enumeratedIndices() {
            if x < prev {
                prev = x
                minI = i
            }
        }
        return minI
    }
}
