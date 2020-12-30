//
//  AnagramGrouper.swift
//  
//
//  Created by Stefan Jaindl on 20.09.20.
//

import Foundation

open class AnagramGrouper {
    public init() { }
    
    open func sortAnagram(array: [String]) -> [String] {
        //Modified bucket sort: Put anagrams in a bucket each!
        //Map: sortedString:Anagrams
        var anagramsMap: [String: [String]] = [:]
        
        //1. Build anagrams map
        for word in array {
            let sorted = String(word.sorted())
            if var anagrams = anagramsMap[sorted] {
                anagrams.append(word)
                anagramsMap[sorted] = anagrams
            } else {
                anagramsMap[sorted] = [word]
            }
        }
        
        //2. Convert map to array
        var groupedAnagrams: [String] = []
        for element in anagramsMap {
            groupedAnagrams.append(contentsOf: element.value)
        }
        
        return groupedAnagrams
    }
}

//extension AnagramGrouper {
//    static let anagramSorter: (Any, Any) -> ComparisonResult = { lhs, rhs in
//        guard let lhs = lhs as? String, let rhs = rhs as? String else {
//            return .orderedAscending
//        }
//
//        if lhs.count != rhs.count {
//            return .orderedAscending
//        }
//
//        //Calculate count of each char of first string
//        var charCounts: [Character: Int] = [:]
//        for char in lhs {
//            if let count = charCounts[char] {
//                charCounts[char] = count + 1
//            } else {
//                charCounts[char] = 1
//            }
//        }
//
//        //Check if second string has same counts - then it is an anagram:
//        for char in rhs {
//            if let count = charCounts[char] {
//                if count <= 0 {
//                    return .orderedAscending
//                }
//                charCounts[char] = count - 1
//            } else {
//                return .orderedAscending
//            }
//        }
//
//        //Check if each char count is zeroed out:
//        for element in charCounts {
//            if element.value != 0 {
//                return .orderedAscending
//            }
//        }
//
//        return .orderedSame
//    }
//}
