//
//  NumberMax.swift
//  
//
//  Created by Stefan Jaindl on 18.11.20.
//

import Foundation

open class NumberMax {
    public init() { }
    
    //Finding max element without if-else and comparison operators
    open func max(first: Int, second: Int) -> Int {
        var firstShifted = first
        var secondShifted = second
        var diff = first ^ second
        
        if diff == 0 {
            //first == second, return any
            return first
        }
        
        while diff != 1 {
            diff >>= 1
            firstShifted >>= 1
            secondShifted >>= 1
        }
        
        let firstBigger = (firstShifted & 0b1) == 1
        let firstValue = Int(truncating: NSNumber(value: firstBigger))
        let secondValue = Int(truncating: NSNumber(value: !firstBigger))
        
        return firstValue * first + secondValue * second
    }
}
