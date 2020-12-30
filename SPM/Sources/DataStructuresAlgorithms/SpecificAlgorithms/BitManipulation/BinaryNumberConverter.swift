//
//  BinaryNumberConverter.swift
//  
//
//  Created by Stefan Jaindl on 31.07.20.
//

import Foundation

open class BinaryNumberConverter {
    
    public init() { }
    
    open func binaryConversionCount(from first: Int, to second: Int) -> Int {
        var result = first ^ second
        var bitsDifferentCount = 0
        
        while result > 0 {
            if result & 0b1 == 1 {
                bitsDifferentCount += 1
            }
            result >>= 1
        }
        
        /* Alternative:
          while result > 0 {
             bitsDifferentCount += 1
             result = result & (result - 1)
          }
         */
        
        return bitsDifferentCount
    }
}
