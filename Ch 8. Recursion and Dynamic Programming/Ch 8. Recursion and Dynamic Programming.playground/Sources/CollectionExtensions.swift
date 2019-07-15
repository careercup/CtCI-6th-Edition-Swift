//
//  CollectionExtensions.swift
//
//  Created by Matthew Carroll on 2/11/16.
//  Copyright © 2016 Third Cup lc. All rights reserved.
//

import Foundation


// MARK: - Dictionary - Adding Entries

public extension Dictionary {
    
    mutating func addEntries<S: Sequence>(sequence: S) where S.Iterator.Element == (Key, Value) {
        sequence.forEach { self[$0.0] = $0.1 }
    }
    
    func addingEntries(from d: [Key: Value]) -> [Key: Value] {
        var dictionary = self
        d.forEach { dictionary[$0.0] = $0.1 }
        return dictionary
    }
    
    func addingEntries<S: Sequence>(from sequence: S) -> Dictionary<Key, Value>
        where S.Iterator.Element == (Key, Value) {
            var dictionary = self
            sequence.forEach { dictionary[$0.0] = $0.1 }
            return dictionary
    }
}

public extension Dictionary where Key: Comparable {
    
    var valuesSortedByKey: [Value] {
        return keys.sorted().map { self[$0]! }
    }
}

// MARK: - First Match

public extension Sequence {
    
    func element(where predicate: (_ element: Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in self {
            if predicate(element) {
                return element
            }
        }
        return nil
    }
    
    func element<T>(where predicate: (_ element: Iterator.Element) -> T?) -> T? {
        for element in self {
            if let x = predicate(element) {
                return x
            }
        }
        return nil
    }
    
    func forAll(predicate: (Iterator.Element) -> Bool) -> Bool {
        for x in self {
            guard predicate(x) else { return false }
        }
        return true
    }
}

public extension Sequence {
    
    func accumulate<T>(initial: T? = nil, combine: ([T], Iterator.Element) -> T) -> [T] {
        var elements: [T] = []
        if let initial = initial {
            elements.append(initial)
        }
        forEach { element in
            let transformed = combine(elements, element)
            elements.append(transformed)
        }
        return elements
    }
}

public extension Sequence {
    
    func reduceWhile<T>(_ initial: T, combine: (T, Iterator.Element) -> T?) -> T {
        var combined = initial
        for element in self {
            guard let result = combine(combined, element) else { return combined }
            combined = result
        }
        return combined
    }
}

extension RangeReplaceableCollection where Iterator.Element: Equatable {
    
    mutating func remove(_ element: Iterator.Element) {
        var copy = Self()
        for x in self {
            guard x != element else { continue }
            copy.append(x)
        }
        self = copy
    }
}

public extension Collection {
    
    func lastIndex(where predicate: (Iterator.Element) -> Bool) -> Index? {
        let reverse = reversed()
        return reverse.firstIndex(where: predicate).map {
            let distance = reverse.distance(from: reverse.startIndex, to: $0)
            return self.index(endIndex, offsetBy: numericCast(distance))
        }
    }
}

extension Sequence {
    
    func slice(where predicate: @escaping (Iterator.Element) -> Bool) -> [Iterator.Element] {
        let dropped = drop { !predicate($0) }
        return dropped.prefix { predicate($0) }
    }
}

/// return the first range of T where predicate is true
public extension Collection {
    
    func takeWhile<T>(predicate: (Index, Iterator.Element) -> T?) -> [T]? {
        var elements: [T] = []
        var index = startIndex
        for el in self {
            guard let element = predicate(index, el) else { break }
            elements.append(element)
            index = self.index(after: index)
        }
        return elements.isEmpty ? nil : elements
    }
}

/// returns the first range of predicate

public extension Collection where SubSequence: Collection, SubSequence.Indices.Iterator.Element == Index  {
    
    func range(where predicate: @escaping (Iterator.Element) -> Bool) -> ClosedRange<Index>? {
        guard let first = firstIndex(where: predicate) else { return nil }
        
        let slice = self[index(after: first)..<endIndex]
        let last = slice.indices.reduceWhile(nil as Index?) {
            predicate(self[$1]) ? $1 : nil
        }
        return last.map { first...$0 } ?? first...first
    }
}
