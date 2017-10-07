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
    
    init(randomIntUpperBound bound: UInt32, randomIntCount: Int) {
        let upperBound = Int(bound)
        self = []
        let zero: Element = 0
        for _ in 0..<randomIntCount {
            let randomInt = upperBound.arc4random_uniform()
            let element = zero.advanced(by: numericCast(randomInt))
            append(element)
        }
    }
}

public extension String {
    
    init(randomLettersOfCount count: Int) {
        let firstAsciiValue = 97
        let maxOffset = 5
        let range = 0..<count
        let characters = range.map { _ -> Character in
            let codeUnit = UInt8(maxOffset.arc4random_uniform() + firstAsciiValue)
            return Character(UnicodeScalar(codeUnit))
        }
        self = String(characters)
    }
}


