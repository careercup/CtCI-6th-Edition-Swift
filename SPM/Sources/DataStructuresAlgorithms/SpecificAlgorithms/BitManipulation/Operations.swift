//
//  Operations.swift
//  
//
//  Created by Stefan Jaindl on 20.11.20.
//

import Foundation

//Implements basic operations only using + operator and bit manipulation
open class Operations {
    public init() { }
    
    open func add(first: Int, second: Int) -> Int {
        return first + second
    }
    
    open func subtract(first: Int, second: Int) -> Int {
        // first - second = -second + first   (-> flipping sign of second)
        // 10 - 4 = -4 + 10 = 6
        let secondFlipped = negate(number: second)
        return first + secondFlipped
    }
    
    open func multiply(first: Int, second: Int) -> Int {
        //Find out smaller value, will be faster in loop
        let smaller = first < second ? first : second
        let bigger = first < second ? second : first
        
        let smallerMSB = signBit(of: smaller)
        let biggerMSB = signBit(of: bigger)
        
        let smallerToMultiply = smallerMSB == 1 ? negate(number: smaller) : smaller
        let biggerToMultiply = biggerMSB == 1 ? negate(number: bigger) : bigger
        
        var result = 0
        var count = 0
        while count < smallerToMultiply {
            result += biggerToMultiply
            count += 1
        }
        
        if smallerMSB != biggerMSB {
            //If one of both numbers are negative, result will be negative
            result = negate(number: result)
        }
        
        return result
    }
    
    open func divide(first: Int, second: Int) -> Int {
        let firstMSB = signBit(of: first)
        let secondMSB = signBit(of: second)
        
        let firstToDivide = firstMSB == 1 ? negate(number: first) : first
        let secondToDivide = secondMSB == 1 ? negate(number: second) : second
        
        var result = 0
        var temp = 0
        while temp <= firstToDivide {
            result += 1
            temp += secondToDivide
        }
        
        if temp > first {
            //Truncate result, if division is with a remainder
            result -= 1
        }
        
        if firstMSB != secondMSB {
            //If one of both numbers are negative, result will be negative
            result = negate(number: result)
        }
        
        return result
    }
    
    private func signBit(of number: Int) -> Int {
        let mask = 1 << (Int.bitWidth - 1) //bitWidth = 64
        return number & mask == 0 ? 0 : 1
    }
    
    
    private func negate(number: Int) -> Int {
        return ~number + 1
    }
}
