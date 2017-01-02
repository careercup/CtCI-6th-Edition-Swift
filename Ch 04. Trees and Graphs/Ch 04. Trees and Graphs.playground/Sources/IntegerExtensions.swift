//
//  IntegerExtensions.swift
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

public extension Integer {
    
    var isEven: Bool {
        return self % 2 == 0
    }
}
