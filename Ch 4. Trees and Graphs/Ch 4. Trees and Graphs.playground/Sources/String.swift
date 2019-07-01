//
//  String.swift
//  Codility
//
//  Created by na on 7/15/19.
//  Copyright © 2019 Third Cup lc. All rights reserved.
//

import Foundation

public extension String {
    
    func replacingOccurrences(of replacementMap: [Character: Character]) -> String {
        return String(map { character in replacementMap[character] ?? character })
    }
    
    mutating func replaceOccurrences(of replacementMap: [Character: Character]) {
        for i in indices {
            if let rep = replacementMap[self[i]] {
                self.replaceSubrange(i...i, with: [rep])
            }
        }
    }
    
    func appending(string: String?) -> String {
        return self + (string ?? "")
    }
    
    var nonEmpty: String? {
        return self.isEmpty ? nil : self
    }
    
    init?(toJoin: [String?], seperator: String = " ") {
        self = ""
        toJoin.forEach { s in
            guard let s = s else { return }
            self += s + seperator
        }
        guard !isEmpty else { return nil }
        removeLast()
    }
}

// MARK: - Substrings of a result

public extension NSTextCheckingResult {
    
    func substrings(of checkedString: String) -> [Substring] {
        return (0..<numberOfRanges).map {
            checkedString.substring(at: range(at: $0))
        }
    }
    
    func substrings(of checkedString: String, captureGroups: CountableRange<Int>) -> [Substring] {
        return captureGroups.map { index in
            checkedString.substring(at: range(at: index))
        }
    }
}

// MARK: - Bridge an objective-c range

public extension String {
    
    func substring(at range: NSRange) -> Substring {
        let start = index(startIndex, offsetBy: range.location)
        let end = index(start, offsetBy: range.length)
        return self[start..<end]
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

public extension String {
    
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

public extension String {
    
    func rangeOf(range: NSRange) -> Range<Index> {
        let start = index(startIndex, offsetBy: range.location)
        let end = index(start, offsetBy: range.length)
        return start..<end
    }
}

// MARK: - Enumerate matches of `regExPattern` in self and return a string of applying `result` to self

public extension String {
    
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
            guard let replacement = replacement(String(match), checkingResult, stop) else { return }
            
            let minLength = min(replacement.count, match.count)
            var replacementString = replacement[..<replacement.index(startIndex, offsetBy: minLength)]
            
            let offset = selfCopy.count - count
            let start = selfCopy.index(startIndex, offsetBy: checkingResult.range.location + offset)
            let end = selfCopy.index(start, offsetBy: checkingResult.range.length)
            selfCopy.replaceSubrange(start..<end, with: replacementString)
            
            if replacementString.count < replacement.count {
                replacementString = replacement[replacementString.endIndex...]
                selfCopy.insert(contentsOf: replacementString, at: end)
            }
        }
        return selfCopy
    }
}


// MARK: - Drop the last character

public extension String {
    
    mutating func dropLast() {
        let start = index(before: endIndex)
        replaceSubrange(start..<endIndex, with: [])
    }
    
    mutating func replaceAtIndex(i: Index, c: Character) {
        guard i < endIndex else { return }
        replaceSubrange(i...i, with: [c])
    }
}


public extension String {
    
    func rangeDistanceOfString(string: String) -> Range<IndexDistance>? {
        guard let range = range(of: string) else { return nil }
        let start = distance(from: startIndex, to: range.lowerBound)
        let end = start + distance(from: range.lowerBound, to: range.upperBound)
        return start..<end
    }
}

public extension String {
    
    func distance(to predicate: (_: Character) -> Bool) -> IndexDistance? {
        return reduceWhile(0) { distance, c -> Int? in
            guard !predicate(c) else { return nil }
            return distance + 1
        }
    }
}
