//
//  FoundationExtensions.swift
//
//  Created by Matthew Carroll on 2/11/16.
//  Copyright © 2016 Matthew Carroll. All rights reserved.
//

import Foundation


public extension Integer where Stride: SignedInteger {
    
    public static func +<SI: SignedInteger>(x: Self, y: SI) -> Self {
        let yInteger = allZeros.advanced(by: numericCast(y))
        return x + yInteger
    }
    
    public static func -<SI: SignedInteger>(x: Self, y: SI) -> Self {
        let yInteger = allZeros.advanced(by: numericCast(y))
        return x - yInteger
    }
    
    public static func *<SI: SignedInteger>(x: Self, y: SI) -> Self {
        let yInteger = allZeros.advanced(by: numericCast(y))
        return x * yInteger
    }
    
    public static func /<SI: SignedInteger>(x: Self, y: SI) -> Self {
        let yInteger = allZeros.advanced(by: numericCast(y))
        return x / yInteger
    }
    
    func pow(_ n: Self) -> Self {
        let selfInt: Int = numericCast(asStride)
        let nInt: Int = numericCast(n.asStride)
        let result = Darwin.pow(Double(selfInt), Double(nInt))
        return Self.allZeros.advanced(by: numericCast(Int(result)))
    }
    
    private var asStride: Stride {
        return Self.allZeros.distance(to: self)
    }
}

//: Similar to EnumerateGenerator, but returns the index of the elment instead of an Int
public extension Collection {
    
    func enumeratedIndices() -> Zip2Sequence<Indices, Self> {
        return zip(indices, self)
    }
}

public extension Collection {
    
    var midIndex: Index {
        let mid = distance(from: startIndex, to: endIndex) / 2
        return index(startIndex, offsetBy: mid)
    }
}

public extension Collection {
    
    func longerAndShorterCollections(other: Self) -> (longerCollection: Self, shorterCollection: Self) {
        return count > other.count ? (self, other) : (other, self)
    }
}

public extension Integer {
    
    var isEven: Bool {
        return self % 2 == 0
    }
}
