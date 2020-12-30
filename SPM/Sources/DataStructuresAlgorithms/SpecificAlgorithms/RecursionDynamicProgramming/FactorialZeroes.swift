//
//  FactorialZeroes.swift
//  
//
//  Created by Stefan Jaindl on 16.11.20.
//

import Foundation

open class FactorialZeroes {
    public init() { }
    
    open func factorialTrailingZeroesCount(number: Int) -> Int {
        return factorialCount(number: number - number % 5, count: 0)
    }
    
    private func factorialCount(number: Int, count: Int) -> Int {
        if number < 5 {
            return count
        }
        
        var currentNumberToCheck = number
        var newCount = count
        
        while currentNumberToCheck % 5 == 0 {
            newCount += 1
            currentNumberToCheck /= 5
        }
        
        return factorialCount(number: number - 5, count: newCount)
    }
}
