//
//  BinaryToStringConverter.swift
//  
//
//  Created by Stefan Jaindl on 27.07.20.
//

import Foundation


open class BinaryToStringConverter {
    
    private let errorString = "ERROR"
    
    public init() { }
    
    //Converts a real number between 0 and 1 to its binary representation
    //x1 * 1 / 2^1 + x2 * 1 / 2^2 + x3 * 1 / 2^3 + ..
    
    func binaryRepresentation(of number: Double) -> String {
        var binary = "."
        var currentNumber = number
        
        if currentNumber <= 0 || currentNumber >= 1 {
            return errorString
        }
        
        while currentNumber > 0 {
            if binary.count >= 32 {
                return errorString
            }
            
            let digit = currentNumber * 2 //Same as shift left by 1
            binary.append(digit >= 1 ? "1" : "0")
            currentNumber = digit >= 1 ? digit - 1 : digit
        }
        
        return binary
    }
}
