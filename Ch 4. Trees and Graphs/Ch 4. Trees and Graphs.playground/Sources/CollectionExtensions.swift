//
//  Collections.swift
//
//  Created by Matthew Carroll on 2/11/16.
//  Copyright © 2017 Third Cup lc. All rights reserved.
//

import Foundation


// MARK: - Imperative First Match

extension Sequence {
    
    func first<T>(where predicate: (_ element: Iterator.Element) -> T?) -> T? {
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

extension Sequence {
    
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

extension Sequence {
    
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

extension Collection {
    
    func lastIndex(where predicate: (Iterator.Element) -> Bool) -> Index? {
        let reverse = reversed()
        return reverse.index(where: predicate).map {
            let distance = reverse.distance(from: reverse.startIndex, to: $0)
            return self.index(endIndex, offsetBy: numericCast(distance))
        }
    }
}

/// return the first range of elements where predicate is true
extension Sequence {
    
    func takeWhile(predicate: (Iterator.Element) -> Bool) -> [Iterator.Element] {
        var elements: [Iterator.Element] = []
        for x in self {
            guard predicate(x) else { break }
            elements.append(x)
        }
        return elements
    }
    
    func dropWhile(predicate: (Iterator.Element) -> Bool) -> SubSequence {
        var i = 0
        for x in self {
            guard predicate(x) else { break }
            i += 1
        }
        return dropFirst(i)
    }
}

extension Sequence where SubSequence: Sequence, SubSequence.Iterator.Element == Iterator.Element {
    
    func slice(where predicate: @escaping (Iterator.Element) -> Bool) -> [Iterator.Element] {
        let dropped = dropWhile { !predicate($0) }
        return dropped.takeWhile { predicate($0) }
    }
}

/// return the first range of T where predicate is true
extension Collection {
    
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
extension Collection where SubSequence: Collection  {
    
    func range(where predicate: @escaping (Iterator.Element) -> Bool) -> ClosedRange<Index>? {
        guard let first = index(where: predicate) else { return nil }
        
        let slice = self[index(after: first)..<endIndex]
        let last = slice.indices.reduceWhile(nil as Index?) {
            predicate(self[$1]) ? $1 : nil
        }
        return last.map { first...$0 } ?? first...first
    }
}

extension Dictionary where Key: Comparable {
    
    var valuesSortedByKey: [Value] {
        return keys.sorted().map { self[$0]! }
    }
}

extension Set {
    
    mutating func filtered(_ isIncluded: (Element) -> Bool) {
        for x in self {
            if !isIncluded(x) {
                remove(x)
            }
        }
    }
    
    mutating func replaceFirst(with: (Element) -> Element?) {
        for x in self {
            guard let replacement = with(x) else { continue }
            remove(x)
            insert(replacement)
            return
        }
    }
    
    subscript(element: Element) -> Element? {
        guard let i = index(of: element) else { return nil }
        return self[i]
    }
}

