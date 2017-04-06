//
//  RandomIntegerExtensions.swift
//
//  Created by Matthew Carroll on 8/17/16.
//  Copyright © 2016 Matthew Carroll. All rights reserved.
//

import Foundation


public extension SignedInteger {
    
    func arc4random_uniform() -> Self {
        precondition(self > 0 && toIntMax() <= UInt32.max.toIntMax(), "\(self) must be in 0..< \(UInt32.max)")
        let random = Darwin.arc4random_uniform(numericCast(self))
        return numericCast(random)
    }
}

public extension Integer where Stride: SignedInteger {
    
    func arc4random_uniformInteger() -> Self {
        precondition(self > 0 && toIntMax() <= UInt32.max.toIntMax(), "\(self) must be in 0..< \(UInt32.max)")
        let selfAsStride = Self.allZeros.distance(to: self)
        let random = Darwin.arc4random_uniform(numericCast(selfAsStride))
        let randomAsStride: Stride = numericCast(random)
        return Self.allZeros.advanced(by: randomAsStride)
    }    
}

public extension Array where Element: Integer, Element.Stride: SignedInteger {
    
    init(randomIntUpperBound bound: UInt32, randomIntCount: Int, negativeValues: Bool = false) {
        let upperBound = Int(bound)
        self = []
        for _ in 0..<randomIntCount {
            let randomInt = upperBound.arc4random_uniform()
            let element = Element.allZeros.advanced(by: numericCast(randomInt))
            append(element)
        }
        if negativeValues {
            let negativeCount = count.arc4random_uniform()
            for _ in 0..<negativeCount {
                let i = count.arc4random_uniform()
                self[i] *= -1
            }
        }
    }
}

public extension String {
    
    init(randomLettersOfCount count: Int) {
        let firstAsciiValue = 65
        let maxOffset = 52
        let range = 0..<count
        let characters = range.map { _ -> Character in
            var offset = maxOffset.arc4random_uniform()
            if offset >= 26 {
                offset += 6
            }
            let codeUnit = UInt8(offset + firstAsciiValue)
            return Character(UnicodeScalar(codeUnit))
        }
        self = String(characters)
    }
}

public extension MutableCollection where Self: RandomAccessCollection {
    
    mutating func shuffle() {
        var i = startIndex
        let beforeEndIndex = index(before: endIndex)
        
        while i < beforeEndIndex {
            let dist = distance(from: i, to: endIndex)
            let randomDistance = dist.arc4random_uniform()
            let j = index(i, offsetBy: randomDistance)
            guard i != j else { continue }
            swap(&self[i], &self[j])
            formIndex(after: &i)
        }
    }
}


public extension RandomAccessCollection where Self: MutableCollection, Indices.SubSequence.Iterator.Element == Index, Index: Strideable, Index.Stride: SignedInteger, Index.Stride.Stride: SignedInteger {
    
    mutating func shuffleInPlace() {
        for i in indices.dropLast() {
            let swapFrom = (i..<endIndex).arc4random
            guard swapFrom != i else { return }
            swap(&self[i], &self[swapFrom])
        }
    }
}

public extension Sequence {
    
    func shuffled() -> [Iterator.Element] {
        var clone = Array(self)
        clone.shuffleInPlace()
        return clone
    }
}

extension Range where Bound: Strideable, Bound.Stride: SignedInteger, Bound.Stride.Stride: SignedInteger {
    
    var arc4random: Bound {
        return lowerBound + count.arc4random_uniform()
    }
}
