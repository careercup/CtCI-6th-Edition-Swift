//
//  OneAwayChecker.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 15.05.20.
//

import Foundation

open class OneAwayChecker {
    
    public init() { }
    
    //Checks whether 2 strings are at most one replace, insert or remove operation away from each other (considering char order)
    open func isOneAway(string1: String, string2: String) -> Bool {
        if string1.count <= 1, string2.count <= 1 { //can't be more than one away
            return true
        }
        
        if string1.count == string2.count {
            return isOneReplaceAway(string1: string1, string2: string2)
        }
        
        if abs(string1.count - string2.count) == 1 {
            return isOneInsertAway(string1: string1, string2: string2)
        }
        
        return false
    }
    
    private func isOneReplaceAway(string1: String, string2: String) -> Bool {
        var diffFound = false
        
        for index in 0 ..< string1.count {
            let firstIndex = string1.index(string1.startIndex, offsetBy: index)
            let secondIndex = string2.index(string2.startIndex, offsetBy: index)
            if string1[firstIndex] != string2[secondIndex]  {
                if diffFound {
                    return false
                }
                diffFound = true
            }
        }
        
        return true
    }
    
    private func isOneInsertAway(string1: String, string2: String) -> Bool {
        var diffFound = false
        var index1 = 0
        var index2 = 0
        
        while index1 < string1.count, index2 < string2.count {
            let firstIndex = string1.index(string1.startIndex, offsetBy: index1)
            let secondIndex = string2.index(string2.startIndex, offsetBy: index2)
            if string1[firstIndex] != string2[secondIndex]  {
                if diffFound {
                    return false
                }
                diffFound = true
                
                if string1.count > string2.count {
                    index1 += 1
                } else {
                    index2 += 1
                }
            } else {
                index1 += 1
                index2 += 1
            }
        }
        
        return true
    }
}
