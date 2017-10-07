//
//  ArraySearching.swift
//
//
//  Created by Matthew Carroll on 10/13/16.
//  Copyright © 2016 Third Cup lc. All rights reserved.
//

import Foundation

//: Similar to EnumerateGenerator, but returns the index of the elment instead of an Int
public extension Collection {
    
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
    
    func enumeratedPairsIndices() -> Zip2Sequence<Zip2Iterator<Indices.Iterator, Iterator>, Zip2Iterator<Indices.Iterator, Iterator>> {
        let left = zip(indices, self).makeIterator()
        var right = left
        let _ = right.next()
        return zip(left, right)
    }
    
    func successiveElements() -> Zip2Sequence<Self, Self.SubSequence> {
        return zip(self, self.dropFirst())
    }
}

public struct ElementPairsIterator<T: Sequence>: IteratorProtocol, Sequence {
    
    var iterator: T.Iterator
    
    init(sequence: T) {
        iterator = sequence.makeIterator()
    }
    
    mutating public func next() -> (T.Element, T.Element)? {
        guard let left = iterator.next(), let right = iterator.next() else { return nil }
        return (left, right)
    }
    
    public func makeIterator() -> ElementPairsIterator<T> {
        return self
    }
}


public extension Sequence {
    
    func elementPairs() -> ElementPairsIterator<Self> {
        return ElementPairsIterator(sequence: self)
    }
}

public extension Collection {
    
    typealias EnumeratedPair = (leftIndex: Index, leftElement: Iterator.Element, rightIndex: Index, rightElement: Iterator.Element)
    
    func successiveElements(where predicate: (_ previousElement: Iterator.Element, _ element: Iterator.Element) -> Bool) -> EnumeratedPair? {
        for (left, right) in enumeratedPairsIndices() {
            guard predicate(left.1, right.1) else { continue }
            return (left.0, left.1, right.0, right.1)
        }
        return nil
    }
    
    func elementPair(where predicate: (_ previousElement: Element, _ element: Element) -> Bool) -> (Element, Element)? {
        return elementPairs().first(where: predicate)
    }
}

public extension Collection where Index: SignedInteger {
    
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

public extension Collection where Iterator.Element: Comparable, SubSequence: Collection {
    
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

public extension Collection where Iterator.Element: Comparable, SubSequence: Collection {
    
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

