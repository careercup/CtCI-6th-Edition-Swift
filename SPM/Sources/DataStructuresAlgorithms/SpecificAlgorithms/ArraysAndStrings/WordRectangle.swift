//
//  WordRectangle.swift
//  
//
//  Created by Stefan Jaindl on 21.12.20.
//

import Foundation

open class WordRectangle {
    public init() { }
    
    open func maxRectangle(of words: [String]) -> [String] {
        guard !words.isEmpty else {
            return []
        }
        
        let wordsByLength = words.sorted(by: { $0.count > $1.count })
        let wordsDict = wordsDictByLen(wordsByLength: wordsByLength)
        let tries = buildTriesByLen(wordsByLength: wordsByLength)
        let sizes = decreasingSizes(to: wordsByLength[0].count)
        
        for size in sizes {
            guard let columnTrie = tries[size.col],
                var wordsSet = wordsDict[size.row] else {
                continue
            }
            
            let maxRectangle = buildRows(rowLen: size.row, colLen: size.col, rootTrie: columnTrie, availableRowWords: &wordsSet)
            if !maxRectangle.isEmpty {
                return maxRectangle
            }
        }
        
        return []
    }
    
    private func buildRows(rowLen: Int, colLen: Int, rootTrie: Trie, availableRowWords: inout Set<[Character]>) -> [String] {
        var tries = [TrieNode]()
        for _ in 0 ..< colLen {
            tries.append(rootTrie.root)
        }
        
        var rows = [String]()
        rows = buildRow(rowLen: rowLen, colLen: colLen, rows: &rows, tries: tries, availableRowWords: &availableRowWords)
        
        return rows
    }
    
    private func buildRow(rowLen: Int, colLen: Int, rows: inout [String], tries: [TrieNode], availableRowWords: inout Set<[Character]>) -> [String] {
        if rows.count == rowLen {
            for colIndex in 0 ..< colLen {
                var colWord = [Character]()
                for rowIndex in 0 ..< rowLen {
                    let row = Array(rows[rowIndex])
                    let char = row[colIndex]
                    colWord.append(char)
                }
                if !availableRowWords.contains(colWord) {
                    return []
                }
            }
            
            return rows
        }
        
        var wordsArray = [String]()
        for word in availableRowWords {
            wordsArray.append(String(word))
        }
        
        let permutations = Permuation<String>().permutations(array: &wordsArray)
        
        for permutation in permutations {
            
            var newTrieNodes = [TrieNode]()
            
            Word:
            for rowWord in permutation {
                let rowChars = Array(rowWord)
                for column in 0 ..< colLen {
                    let trie = tries[column]
                    let charOfRowWord = rowChars[column]
                    if let child = trie.childNodes[charOfRowWord] {
                        newTrieNodes.append(child)
                    } else {
                        continue Word
                    }
                }
                
                availableRowWords.remove(rowChars)
                rows.append(String(rowChars))
                let buildRows = buildRow(rowLen: rowLen, colLen: colLen, rows: &rows, tries: newTrieNodes, availableRowWords: &availableRowWords)
                rows.removeLast()
                availableRowWords.insert(rowChars)
                
                if !buildRows.isEmpty {
                    return buildRows
                }
            }
        }
        
        return []
    }
    
    private func decreasingSizes(to: Int) -> [(row: Int, col: Int)] {
        var sizes = [(row: Int, col: Int)]()
        for row in 1 ... to {
            for col in 1 ... to {
                sizes.append((row: row, col: col))
            }
        }
        
        return sizes.sorted(by: { $0.row * $0.col > $1.row * $1.col })
    }
    
    private func wordsDictByLen(wordsByLength: [String]) -> [Int: Set<[Character]>] {
        var dict = [Int: Set<[Character]>]()
        
        for word in wordsByLength {
            if word.isEmpty {
                continue
            }
            
            if var curEntry = dict[word.count] {
                curEntry.insert(Array(word))
                dict[word.count] = curEntry
            } else {
                var set = Set<[Character]>()
                set.insert(Array(word))
                dict[word.count] = set
            }
        }
        
        return dict
    }
    
    private func buildTriesByLen(wordsByLength: [String]) -> [Int: Trie] {
        var tries = [Int: Trie]()
        
        for word in wordsByLength {
            if word.isEmpty {
                continue
            }
            
            if let curTrie = tries[word.count] {
                curTrie.insert(word: word)
            } else {
                let curTrie = Trie()
                curTrie.insert(word: word)
                tries[word.count] = curTrie
            }
        }
        
        return tries
    }
}
