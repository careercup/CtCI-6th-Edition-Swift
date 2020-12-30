//
//  T9Keyboard.swift
//  
//
//  Created by Stefan Jaindl on 30.11.20.
//

import Foundation

public struct KeyMapping {
    let mapping: [Int: [Character]]
}

open class T9Keyboard {
    let keyMapping: KeyMapping?
    let validWords: Trie //trie with root node
    
    let defaultKeyMapping = KeyMapping(mapping: [1: [],
                                                 2: ["a", "b", "c"],
                                                 3: ["d", "e", "f"],
                                                 4: ["g", "h", "i"],
                                                 5: ["j", "k", "l"],
                                                 6: ["m", "n", "o"],
                                                 7: ["p", "q", "r", "s"],
                                                 8: ["t", "u", "v"],
                                                 9: ["w", "x", "y", "z"]])
    
    public init(validWords: Trie, keyMapping: KeyMapping? = nil) {
        self.validWords = validWords
        self.keyMapping = keyMapping
    }
    
    private func getMapping() -> [Int: [Character]] {
        let mapping = keyMapping ?? defaultKeyMapping
        return mapping.mapping
    }
    
    //given: Mapping, digits, valid words
    //returns: Possible valid words (autocomplete)
    open func autocomplete(for digits: [Int]) throws -> [String] {
        guard !digits.isEmpty else {
            return []
        }
        
        return try autocomplete(for: digits, mapping: getMapping(), wordSoFar: [], currentTrieNode: validWords.root)
    }
    
    private func autocomplete(for digits: [Int], mapping: [Int: [Character]], wordSoFar: [Character], currentTrieNode: TrieNode?) throws -> [String] {
        guard let currentTrieNode = currentTrieNode else {
            return []
        }
        
        if digits.isEmpty {
            return completeWords(wordSoFar: wordSoFar, currentTrieNode: currentTrieNode)
        }
        
        var validWords: [String] = []
        
        let firstDigit = digits[0]
        let remainingDigits = Array(digits[1 ..< digits.count])
        
        guard firstDigit >= 0, firstDigit <= 9, let chars = mapping[firstDigit] else {
            throw NSError(domain: "T9Keyboard: Invalid mapping", code: 0, userInfo: nil)
        }
        
        for char in chars {
            let node = currentTrieNode.childNodes[char]
            var newWord = wordSoFar
            newWord.append(char)
            validWords.append(contentsOf: try autocomplete(for: remainingDigits, mapping: mapping, wordSoFar: newWord, currentTrieNode: node))
        }
        
        return validWords
    }
    
    private func completeWords(wordSoFar: [Character], currentTrieNode: TrieNode) -> [String] {
        var validWords: [String] = []
        
        if currentTrieNode.terminates {
            validWords.append(String(wordSoFar))
        }
        
        currentTrieNode.childNodes.forEach { child in
            let node = child.value
            var newWord = wordSoFar
            newWord.append(child.key)
            validWords.append(contentsOf: completeWords(wordSoFar: newWord, currentTrieNode: node))
        }
        
        return validWords
    }
}
