//
//  RandomIntegerExtensions.swift
//
//  Created by Matthew Carroll on 8/17/16.
//  Copyright © 2016 Matthew Carroll. All rights reserved.
//

import Foundation

public extension FixedWidthInteger {
    
    func pow(_ n: Self) -> Self {
        let selfInt: Int = numericCast(asStride)
        let nInt: Int = numericCast(n.asStride)
        let result = Darwin.pow(Double(selfInt), Double(nInt))
        return Self.init().advanced(by: numericCast(Int(result)))
    }
    
    private var asStride: Stride {
        return -distance(to: 0)
    }
}

public extension Array where Element: FixedWidthInteger {
    
    init(randomInUpperBound bound: Int, randomIntCount: Int) {
        self = []
        let range: Range<Element> = 0..<numericCast(bound)
        for _ in 0..<randomIntCount {
            let randomInt = Element.random(in: range)
            append(randomInt)
        }
    }
}

