//
//  PatternMatcher.swift
//  
//
//  Created by Stefan Jaindl on 28.11.20.
//

import Foundation

//Checks whether string matches patterns in O(n^2) time. n for iterating through possible lenghts and n for building strings each
//Notice that in most cases early returns are done .. e.g. if one substring doesn't match or we there are impossible counts for a length.
open class PatternMatcher {
    public init() { }
    
    open func matches(value: String, pattern: [PatternValue]) -> Bool {
        guard !pattern.isEmpty, !value.isEmpty else {
            return false
        }
        
        //Count a's & b's in pattern
        let aCount = pattern.filter { $0 == .a }.count
        let bCount = pattern.filter { $0 == .b }.count
        
        if !basicChecks(value: value, aCount: aCount, bCount: bCount) {
            return false
        }
        
        //check increasing lengths (min len = 1)
        let minLen = 1
        let maxLen = value.count - bCount
        
        PatternCheck:
        for aLenght in minLen ..< maxLen {
            let bLenght = (value.count - (aLenght * aCount)) / bCount
            
            if bLenght * bCount + aLenght * aCount != value.count {
                //impossible pattern match
                continue PatternCheck
            }
            
            if checkPattern(aLenght: aLenght, bLength: bLenght, value: value, pattern: pattern) {
                return true
            }
        }
        
        return false
    }
    
    private func basicChecks(value: String, aCount: Int, bCount: Int) -> Bool {
        if value.count < aCount + bCount {
            return false
        }
        
        if aCount == 0 {
            return value.count % bCount == 0
        }
        
        if bCount == 0 {
            return value.count % aCount == 0
        }
        
        return true
    }
    
    private func checkPattern(aLenght: Int, bLength: Int, value: String, pattern: [PatternValue]) -> Bool {
        var aPatternCount = 0
        var bPatternCount = 0
        var expectedA: String?
        var expectedB: String?
        for patternValue in pattern {
            let offset = aPatternCount * aLenght + bPatternCount * bLength
            
            switch patternValue {
            case .a:
                if !patternValueIsValid(value: value, offset: offset, lenght: aLenght, expected: &expectedA) {
                    return false
                }
                aPatternCount += 1
            case .b:
                if !patternValueIsValid(value: value, offset: offset, lenght: bLength, expected: &expectedB) {
                    return false
                }
                bPatternCount += 1
            }
        }
        
        return true
    }
    
    private func patternValueIsValid(value: String, offset: Int, lenght: Int, expected: inout String?) -> Bool {
        let substring = String(value[value.index(pos: offset) ..< value.index(pos: offset + lenght)])
        if let expectedValue = expected, expectedValue != substring {
            return false
        }
        expected = substring
        
        return true
    }
}

public extension String {
    func index(pos: Int) -> String.Index {
        return index(startIndex, offsetBy: pos)
    }
}

public enum PatternValue {
    case a
    case b
}
