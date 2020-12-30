//  StringRotation.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 20.05.20.
//

import Foundation

open class StringRotation {
    
    public init() { }
    
    open func isRotation(firstString: String, secondString: String) -> Bool {
        if firstString.count != secondString.count {
            return false
        }
        
        if firstString == secondString {
            return false
        }
        
        if firstString.count <= 1 {
            return true
        }
        
        let appendedString = secondString + secondString
        return appendedString.contains(firstString)
    }
}
