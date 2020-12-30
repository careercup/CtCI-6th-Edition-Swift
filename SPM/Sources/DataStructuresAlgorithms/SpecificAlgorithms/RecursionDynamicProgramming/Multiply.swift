//
//  Multiplyer.swift
//  
//
//  Created by Stefan Jaindl on 16.08.20.
//

import Foundation

open class Multiplyer {
    
    public init() { }
    
    open func multiply(_ first: UInt, with second: UInt) -> UInt {
        if first == 0 || second == 0 {
            return 0
        }
        
        let bigger = first > second ? first : second
        let smaller = first == bigger ? second : first
        
        if smaller == 1 {
            return bigger
        }
        
        return multiply(number: bigger, times: smaller)
    }
    
    private func multiply(number: UInt, times: UInt) -> UInt {
        if times == 1 {
            return number
        }
        
        let timesEven = times % 2 == 0 ? times : times - 1
        let remainder = times % 2 == 0 ? 0 : number
        
        return remainder + multiply(number: number << 1, times: timesEven >> 1)
    }
}
