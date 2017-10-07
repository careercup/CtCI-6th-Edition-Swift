//
//  IntegerExtensions.swift
//
//  Created by Matthew Carroll on 2/11/16.
//  Copyright © 2016 Matthew Carroll. All rights reserved.
//

import Foundation


public extension BinaryInteger where Stride: SignedInteger {
    
    public func pow(_ n: Self) -> Self {
        let selfInt: Int = numericCast(asStride)
        let nInt: Int = numericCast(n.asStride)
        let result = Darwin.pow(Double(selfInt), Double(nInt))
        let zero: Self = 0
        return zero.advanced(by: Int(result))
    }
    
    var asStride: Stride {
        return -(distance(to: 0))
    }
}

public extension BinaryInteger {
    
    var isEven: Bool {
        return self % 2 == 0
    }
}


