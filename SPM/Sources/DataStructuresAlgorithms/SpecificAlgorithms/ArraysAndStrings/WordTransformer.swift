//
//  WordTransformer.swift
//  
//
//  Created by Stefan Jaindl on 18.12.20.
//

import Foundation

private let wildcardChar: Character = "*"

open class WordTransformer {
    
    let words: Set<String>
    var oneEditAway: [WildcardMapping: Set<[Character]>] = [:]
    
    public init(words: Set<String>) {
        self.words = words
        buildValidWords(words: words)
    }
    
    open func transform(_ first: String, into second: String) -> [String] {
        guard !first.isEmpty, !second.isEmpty, first.count == second.count else {
            return []
        }
        
        var checked = Set<[Character]>()
        checked.insert(Array(first))
        return transform(searched: Array(second), path: [Array(first)], checked: &checked)
    }
    
    private func transform(searched: [Character], path: [[Character]], checked: inout Set<[Character]>) -> [String] {
        let current = Array(path[path.count - 1])
        
        if current == searched {
            var stringPath: [String] = []
            for chars in path {
                stringPath.append(String(chars))
            }
            
            return stringPath
        }
        
        for index in 0 ..< searched.count {
            let mapping = WildcardMapping(chars: current, wildcardIndex: index)
            
            for validChar in oneEditAway[mapping] ?? [] {
                let changedWord = validChar
                
                if !checked.contains(changedWord) {
                    checked.insert(changedWord)
                    var newPath = path
                    newPath.append(changedWord)
                    
                    let subPath = transform(searched: searched, path: newPath, checked: &checked)
                    if !subPath.isEmpty {
                        return subPath
                    }
                }
            }
        }
        
        return []
    }
    
    private func buildValidWords(words: Set<String>) {
        for word in words {
            for (index, _) in word.enumerated() {
                let mapping = WildcardMapping(chars: Array(word), wildcardIndex: index)
                if var oneAway = oneEditAway[mapping] {
                    oneAway.insert(Array(word))
                    oneEditAway[mapping] = oneAway
                } else {
                    oneEditAway[mapping] = [Array(word)]
                }
            }
        }
    }
}

public struct WildcardMapping: Hashable, Equatable {
    let chars: [Character]
    let wildcardIndex: Int
    
    init(chars: [Character], wildcardIndex: Int) {
        var adaptedChars = chars
        adaptedChars[wildcardIndex] = wildcardChar
        
        self.chars = adaptedChars
        self.wildcardIndex = wildcardIndex
    }
    
    public static func == (lhs: WildcardMapping, rhs: WildcardMapping) -> Bool {
        return lhs.chars == rhs.chars && lhs.wildcardIndex == rhs.wildcardIndex
    }
}
