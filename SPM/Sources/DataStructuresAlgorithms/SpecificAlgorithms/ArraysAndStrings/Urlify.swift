//
//  Urlify.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 10.05.20.
//

import Foundation

open class Urlifier {
    
    public init() { }
    
    open func urlify(_ input: inout [Character]) {
        if input.isEmpty {
            return
        }
        
        var charCount = input.count
        
        //count nr. of spaces to replace:
        var spaces = 0
        for charCount in 0 ..< input.count {
            if input[charCount] == " " {
                spaces += 1
            }
        }
        
        //count incl. replaced spaces (%20)
        var finalCount = input.count + spaces * (3 - 1)
        
        //resize array, if necessary:
        while input.count < finalCount {
            input.append(" ")
        }
        
        //We can optimize here: if charCount == finalCount, we already have replaced all blanks
        while charCount != finalCount {
            let char = input[charCount - 1]
            if char == " " {
                input[finalCount - 3] = "%"
                input[finalCount - 2] = "2"
                input[finalCount - 1] = "0"
                finalCount -= 3
            } else {
                input[finalCount - 1] = char
                finalCount -= 1
            }
            charCount -= 1
        }
    }
}
