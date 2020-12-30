//
//  SpaceInserter.swift
//  
//
//  Created by Stefan Jaindl on 10.12.20.
//

import Foundation

open class SpaceInserter {
    public init() { }
    
    open func insertSpaces(into string: String, wordsDict: [String]) -> String {
        guard !wordsDict.isEmpty, !string.isEmpty else {
            return string
        }
        
        let characters = Array(string)
        var spacedString: [Character] = []
        let trie = buildTrie(wordsDict: wordsDict)
        
        var index = 0
        while index < characters.count {
            let remainder = Array(characters[index ..< characters.count])
            let word = findWord(string: remainder, trie: trie)
            if !word.isEmpty {
                if !spacedString.isEmpty, spacedString[spacedString.count - 1] != " " {
                    spacedString += " "
                }
                spacedString.append(contentsOf: "\(String(word))")
                if index != characters.count - 1 {
                    spacedString.append(" ")
                }
                index += word.count
            } else {
                spacedString.append(characters[index])
                index += 1
            }
        }
        
        return String(spacedString).trimmingCharacters(in: CharacterSet(arrayLiteral: " "))
    }
    
    private func findWord(string: [Character], trie: Trie) -> [Character] {
        var trieNode: TrieNode? = trie.root
        var found: [Character] = []
        var curIndex = 0
        
        while curIndex < string.count, let node = trieNode {
            let char = string[curIndex]
            trieNode = node.childNodes[char]
            
            if trieNode?.terminates == true {
                found = Array(string[0 ... curIndex])
            }
            
            curIndex += 1
        }
        
        return found
    }
    
    private func buildTrie(wordsDict: [String]) -> Trie {
        let trie = Trie()
        
        for word in wordsDict {
            trie.insert(word: word)
        }
        
        return trie
    }
}
