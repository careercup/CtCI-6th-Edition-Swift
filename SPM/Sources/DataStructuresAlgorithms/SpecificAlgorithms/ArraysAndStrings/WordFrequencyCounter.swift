//
//  WordFrequencyCounter.swift
//  
//
//  Created by Stefan Jaindl on 15.11.20.
//

import Foundation

open class WordFrequencyCounter {
    private var wordCounts: [String: Int] = [:]
    
    public init(words: [String]) {
        for word in words {
            let adjusted = word.lowercased().trimmingCharacters(in: CharacterSet(charactersIn: " "))
            let count: Int
            if let currentCount = wordCounts[adjusted] {
                count = currentCount + 1
            } else {
                count = 1
            }
            
            wordCounts[adjusted] = count
        }
    }
    
    open func count(of word: String) -> Int {
        return wordCounts[word.lowercased().trimmingCharacters(in: CharacterSet(charactersIn: " "))] ?? 0
    }
}
