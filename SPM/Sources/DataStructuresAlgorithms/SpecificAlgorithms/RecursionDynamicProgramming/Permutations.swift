//
//  Permutations.swift
//  
//
//  Created by Stefan Jaindl on 19.08.20.
//

import Foundation

open class Permutations {
    public init() { }
    
    open func permutationsWithoutDuplicates(of string: String) -> [String] {
        if string.isEmpty {
            return [""]
        }
        
        var permutations: [String] = []
        for char in string {
            if permutations.isEmpty {
                permutations.append(String(char))
                continue
            }
            
            var newPermutations: [String] = []
            for lastLevelPermutation in permutations {
                for index in 0 ... lastLevelPermutation.count {
                    var newPermutation = lastLevelPermutation
                    newPermutation.insert(char, at: lastLevelPermutation.index(lastLevelPermutation.startIndex, offsetBy: index))
                    newPermutations.append(newPermutation)
                }
            }
            permutations = newPermutations
        }
        
        return permutations
    }
    
    open func permutationsWithDuplicates(of string: String) -> [String] {
        return permutations(of: String(string.sorted()))
    }
    
    private func permutations(of string: String) -> [String] {
        if string.count <= 1 {
            return [string]
        }
        
        var perms: [String] = []
        
        for (index, char) in string.enumerated() {
            if index > 0, string[string.index(string.startIndex, offsetBy: index - 1)] == char {
                continue //char is a duplicate of previous char - so, skip duplicate
            }
            
            var prefix = ""
            var postfix = ""
            
            if index > 0 {
                let prefixIndex = string.index(string.startIndex, offsetBy: index - 1)
                prefix = String(string[string.startIndex ... prefixIndex])
            }
            
            if index < string.count - 1 {
                let postfixIndex = string.index(after: string.index(string.startIndex, offsetBy: index))
                postfix = String(string[postfixIndex ..< string.endIndex])
            }
            
            let remainder = "\(prefix)\(postfix)"
            
            let subPermuations = permutations(of: remainder)
            for subPermutation in subPermuations {
                perms.append("\(char)\(subPermutation)")
            }
        }
        
        return perms
    }
}
