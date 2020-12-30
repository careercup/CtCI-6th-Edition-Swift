//
//  ParensBuilder.swift
//  
//
//  Created by Stefan Jaindl on 24.08.20.
//

import Foundation

open class ParensBuilder {
    public init() { }
    
    open func parens(numberOfBrackets: Int) -> [String] {
        if numberOfBrackets <= 1 {
            return [""]
        }
        
        let bracketCount = BracketCount(opening: numberOfBrackets - 1, closing: numberOfBrackets)
        
        return parens(input: "(", bracketCount: bracketCount)
    }
    
    private func parens(input: String, bracketCount: BracketCount) -> [String] {
        if bracketCount.opening == 0 {
            //base case
            var complete = input
            for _ in 0 ..< bracketCount.closing {
                complete.append(")")
            }
            
            return [complete]
        }
        
        var combisClosing: [String] = []
        if bracketCount.closing > bracketCount.opening {
            let next = "\(input))"
            let newBracketCount = BracketCount(opening: bracketCount.opening, closing: bracketCount.closing - 1)

            combisClosing = parens(input: next, bracketCount: newBracketCount)
        }
        
        var combisOpening: [String] = []
        let next = "\(input)("
        let newBracketCount = BracketCount(opening: bracketCount.opening - 1, closing: bracketCount.closing)
        
        combisOpening = parens(input: next, bracketCount: newBracketCount)
        
        return combisClosing + combisOpening
    }
}

private struct BracketCount: Hashable, Equatable {
    var opening: Int
    var closing: Int
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.opening == rhs.opening && lhs.closing == rhs.closing
    }
}
