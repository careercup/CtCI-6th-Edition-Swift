//
//  MultiSearch.swift
//  
//
//  Created by Stefan Jaindl on 11.12.20.
//

import Foundation

open class MultiSearch {
    public init() { }
    
    //returns matched sub arrays
    open func multiSearch(in string: String, for subArrays: [String]) -> [String] {
        guard !string.isEmpty, !subArrays.isEmpty else {
            return []
        }
        
        var matched = Set<String>()
        let trie = buildTrie(for: subArrays)
        let chars = Array(string)
        
        for index in 0 ..< string.count {
            let subStrings = isSubArray(string: chars, index: index, trie: trie)
            subStrings.forEach { substring in
                matched.insert(substring)
            }
        }
        
        var matchedArray: [String] = []
        matchedArray.append(contentsOf: matched)
        
        return matchedArray
    }
    
    private func isSubArray(string: [Character], index: Int, trie: Trie) -> Set<String> {
        var trieNode: TrieNode? = trie.root
        var subStrings = Set<String>()
        var charsSoFar: [Character] = []
        
        var currentIndex = index
        while currentIndex < string.count, trieNode != nil {
            let char = string[currentIndex]
            trieNode = trieNode?.childNodes[char]
            if trieNode == nil {
                break
            }
            
            charsSoFar.append(char)
            if trieNode?.terminates == true {
                subStrings.insert(String(charsSoFar))
            }
            
            currentIndex += 1
        }
        
        return subStrings
    }
    
    private func buildTrie(for array: [String]) -> Trie {
        let trie = Trie()
        
        for string in array {
            trie.insert(word: string)
        }
        
        return trie
    }
}
