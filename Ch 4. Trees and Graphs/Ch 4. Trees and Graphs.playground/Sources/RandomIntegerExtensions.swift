//
//  RandomIntegerExtensions.swift
//
//  Created by Matthew Carroll on 8/17/16.
//  Copyright © 2016 Matthew Carroll. All rights reserved.
//

import Foundation


public extension FixedWidthInteger where Stride: SignedInteger {
    
    func arc4random_uniform() -> Self {
        precondition(self > 0 && self <= UInt32.max, "\(self) must be in 0..< \(UInt32.max)")
        let selfAsStride = -distance(to: 0)
        let random = Darwin.arc4random_uniform(numericCast(selfAsStride))
        let zero = self - self
        let randomAsStride: Stride = numericCast(random)
        return zero.advanced(by: randomAsStride)
    }
    
    static func arc4random_uniform(upperBound: Self) -> Self {
        return upperBound.arc4random_uniform()
    }
}

public extension Array where Element: FixedWidthInteger {
    
    init(randomIntUpperBound bound: UInt32, randomIntCount: Int, negativeValues: Bool = false) {
        let upperBound = Int(bound)
        self = []
        let zero: Element = 0
        for _ in 0..<randomIntCount {
            let randomInt = upperBound.arc4random_uniform()
            let element = zero.advanced(by: numericCast(randomInt))
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

public extension MutableCollection where Self: RandomAccessCollection, IndexDistance: FixedWidthInteger, IndexDistance.Stride: SignedInteger {
    
    mutating func shuffle() {
        var i = startIndex
        let beforeEndIndex = index(before: endIndex)
        
        while i < beforeEndIndex {
            let dist = distance(from: i, to: endIndex)
            let randomDistance = dist.arc4random_uniform()
            let j = index(i, offsetBy: randomDistance)
            guard i != j else { continue }
            self.swapAt(i, j)
            formIndex(after: &i)
        }
    }
}

public extension RandomAccessCollection where Self: MutableCollection, Index: Strideable & FixedWidthInteger, Index.Stride: SignedInteger & FixedWidthInteger, Index.Stride.Stride: SignedInteger & FixedWidthInteger {
    
    mutating func shuffleInPlace() {
        for i in indices.dropLast() {
            let swapFrom = (i..<endIndex).arc4random
            guard swapFrom != i else { return }
            self.swapAt(i, swapFrom)
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

extension Range where Bound: FixedWidthInteger, Bound.Stride: FixedWidthInteger & SignedInteger, Bound.Stride.Stride: SignedInteger  {
    
    var arc4random: Bound {
        return lowerBound + numericCast(count.arc4random_uniform())
    }
}
