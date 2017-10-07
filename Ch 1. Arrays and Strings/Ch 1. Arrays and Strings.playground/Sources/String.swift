//
//  String.swift
//
//  Created by Matthew Carroll on 2/11/16.
//  Copyright © 2017 Third Cup lc. All rights reserved.
//

import Foundation


// MARK: - String - Appending an optional string

extension String {
    
    func replacingOccurrences(of replacementMap: [Character: Character]) -> String {
        return String(characters.map { character in replacementMap[character] ?? character })
    }
    
    mutating func replaceOccurrences(of replacementMap: [Character: Character]) {
        withMutableCharacters { characterView in
            characterView = CharacterView(characterView.map { character -> Character in
                replacementMap[character] ?? character
            })
        }
    }
    
    func appending(string: String?) -> String {
        return self + (string ?? "")
    }
    
    var nonEmpty: String? {
        return self.isEmpty ? nil : self
    }
    
    init?(toJoin: [String?], seperator: String = " ") {
        var string = ""
        toJoin.forEach { s in
            guard let s = s else { return }
            string += s + seperator
        }
        guard !string.isEmpty else { return nil }
        string.dropLast()
        self = string
    }
}

// MARK: - Bridge an objective-c range

extension String {
    
    func substring(at range: NSRange) -> String {
        let start = index(startIndex, offsetBy: range.location)
        let end = index(start, offsetBy: range.length)
        return String(self[start..<end])
    }
    
    var nsRange: NSRange {
        return NSRange(location: 0, length: utf16.count)
    }
    
    func nsRangeOf(range: Range<Index>) -> NSRange {
        let location = distance(from: startIndex, to: range.lowerBound)
        let length = distance(from: range.lowerBound, to: range.upperBound)
        return NSRange(location: location, length: length)
    }
}

extension String.CharacterView {
    
    func distanceTo(character: Character) -> IndexDistance? {
        var distance = 0
        for c in self {
            if c == character {
                return distance
            }
            distance += 1
        }
        return nil
    }
}

extension String.CharacterView {
    
    func rangeOf(range: NSRange) -> Range<Index> {
        let start = index(startIndex, offsetBy: range.location)
        let end = index(start, offsetBy: range.length)
        return start..<end
    }
}

// MARK: - Enumerate matches of `regExPattern` in self and return a string of applying `result` to self

extension String {
    
    func replacingMatches(of regExPattern: String, options: NSRegularExpression.Options = [], replacement: @escaping (_ match: String) -> String?) -> String? {
        return replacingMatches(of: regExPattern, options: options, range: startIndex..<endIndex) { match, _, _ in
            replacement(match)
        }
    }
    
    func replacingMatches(of pattern: String, options: NSRegularExpression.Options = [], range: Range<Index>, replacement: @escaping (_ match: String, _ result: NSTextCheckingResult, _ stop: UnsafeMutablePointer<ObjCBool>) -> String?) -> String? {
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else { return nil }
        var selfCopy = self
        let nsRange = self.nsRangeOf(range: range)
        
        regex.enumerateMatches(in: self, options: [], range: nsRange) { checkingResult, _, stop in
            guard let checkingResult = checkingResult else { return }
            let match = substring(at: checkingResult.range)
            guard let replacement = replacement(match, checkingResult, stop) else { return }
            
            let minLength = min(replacement.characters.count, match.characters.count)
            var replacementString = String(replacement[..<replacement.index(startIndex, offsetBy: minLength)])
            
            let offset = selfCopy.characters.count - characters.count
            let start = selfCopy.index(startIndex, offsetBy: checkingResult.range.location + offset)
            let end = selfCopy.index(start, offsetBy: checkingResult.range.length)
            selfCopy.replaceSubrange(start..<end, with: replacementString)
            
            if replacementString.characters.count < replacement.characters.count {
                replacementString = String(replacement[replacementString.endIndex...])
                selfCopy.insert(contentsOf: replacementString.characters, at: end)
            }
        }
        return selfCopy
    }
}

// MARK: - Capture Groups of a result

extension NSTextCheckingResult {
    
    func substrings(of checkedString: String) -> [String] {
        return (0..<numberOfRanges).map {
            checkedString.substring(at: range(at: $0))
        }
    }
    
    func substrings(of checkedString: String, captureGroups: CountableRange<Int>) -> [String] {
        return captureGroups.map { index in
            checkedString.substring(at: range(at: index))
        }
    }
}

extension NSRegularExpression {
    
    func matches(in string: String) -> [NSTextCheckingResult] {
        return matches(in: string, range: string.nsRange)
    }
}

// MARK: - Drop the last character

public extension String {
    
    mutating func dropLast() {
        withMutableCharacters { $0 = $0.dropLast() }
    }
    
    mutating func replaceAtIndex(i: Index, c: Character) {
        guard i < endIndex else { return }
        withMutableCharacters { cv in
            cv.replaceSubrange(i...i, with: [c])
        }
    }
}

extension String {
    
    func rangeDistanceOfString(string: String) -> Range<IndexDistance>? {
        guard let range = range(of: string) else { return nil }
        let start = distance(from: startIndex, to: range.lowerBound)
        let end = start + distance(from: range.lowerBound, to: range.upperBound)
        return start..<end
    }
}

extension String {
    
    func distance(to predicate: (_: Character) -> Bool) -> IndexDistance? {
        return characters.reduceWhile(0) { distance, c -> Int? in
            guard !predicate(c) else { return nil }
            return distance + 1
        }
    }
}
