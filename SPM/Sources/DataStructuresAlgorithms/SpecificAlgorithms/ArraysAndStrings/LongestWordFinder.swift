//
//  LongestWordFinder.swift
//  
//
//  Created by Stefan Jaindl on 11.12.20.
//

import Foundation

open class LongestWordFinder {
    
    public init() { }
    
    //Finds longest word made up of another words
    open func findLongestCombinedWord(of words: [String]) -> String? {
        guard words.count > 1 else {
            return nil
        }
        
        let trie = buildTrie(of: words)
        let longest = longestWord(trieNode: trie.root, shorterWordFound: false, chars: [])
        
        return longest.isEmpty ? nil : String(longest)
    }
    
    private func longestWord(trieNode: TrieNode, shorterWordFound: Bool, chars: [Character]) -> [Character] {
        let terminates = trieNode.terminates
        var longest: [Character] = []
        
        if terminates && shorterWordFound {
            longest = chars
        }
        
        for child in trieNode.childNodes {
            var newChars = chars
            newChars.append(child.key)
            
            let longestChild = longestWord(trieNode: child.value, shorterWordFound: shorterWordFound || terminates, chars: newChars)
            if longestChild.count > longest.count {
                longest = longestChild
            }
        }
        
        return longest
    }
    
    private func buildTrie(of words: [String]) -> Trie {
        let trie = Trie()
        for word in words {
            trie.insert(word: word)
        }
        
        return trie
    }
}
