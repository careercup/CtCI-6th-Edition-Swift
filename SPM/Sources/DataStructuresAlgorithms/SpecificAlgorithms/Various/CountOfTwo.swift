//
//  CountOfTwo.swift
//  
//
//  Created by Stefan Jaindl on 05.12.20.
//

import Foundation

//Calculates all 2's in the range of 0 ... number (counting e.g. 22 2 times)
open class CountOfTwos {
    public init() { }
    
    open func countOfTwos(number: Int) -> Int {
        return countOfTwos(number: number, divisor: 10, multiplicator: 1)
    }
    
    private func countOfTwos(number: Int, divisor: Int, multiplicator: Int) -> Int {
        if number < multiplicator {
            return 0 //Base Case
        }
        
        var twosCountAtLevel = (number / divisor) * multiplicator
        let remainder = number % divisor
        if remainder >= 3 * multiplicator {
            twosCountAtLevel += multiplicator
        } else if remainder >= 2 * multiplicator {
            twosCountAtLevel += (remainder % multiplicator) + 1
        }
        
        return twosCountAtLevel + countOfTwos(number: number, divisor: divisor * 10, multiplicator: multiplicator * 10)
    }
}
