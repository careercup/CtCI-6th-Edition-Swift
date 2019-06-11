//
//  FoundationExtensions.swift
//
//  Created by Matthew Carroll on 2/11/16.
//  Copyright © 2016 Matthew Carroll. All rights reserved.
//

import Foundation

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

public extension FixedWidthInteger {
    
    var isEven: Bool {
        return self % 2 == 0
    }
}
