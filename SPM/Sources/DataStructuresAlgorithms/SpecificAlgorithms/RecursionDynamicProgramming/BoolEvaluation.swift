//
//  BoolEvaluation.swift
//  
//
//  Created by Stefan Jaindl on 27.08.20.
//

import Foundation

open class BoolEvaluation {
    
    public init() { }
    
    open func boolEvaluation(expression: String, expectedResult: Bool) throws -> Int {
        if expression.isEmpty {
            return 0
        }
        
        var lookup: [String: (trueCount: Int, falseCount: Int)] = [:]
        
        let result = try countValidParenthesesPositions(expression: expression, lookup: &lookup)
        
        return expectedResult ? result.trueCount : result.falseCount
    }
    
    private func countValidParenthesesPositions(expression: String, lookup: inout [String: (trueCount: Int, falseCount: Int)]) throws -> (trueCount: Int, falseCount: Int) {
        if expression.count == 1 {
            //base case: 1 or 0
            var result: (trueCount: Int, falseCount: Int) = (0, 0)
            let value = expression.toBool()
            if value {
                result.trueCount = 1
            } else {
                result.falseCount = 1
            }
            
            return result
        }
        
        if let result = lookup[expression] {
            return result
        }
            
        var cumulatedResult: (trueCount: Int, falseCount: Int) = (0, 0)
        for index in stride(from: 1, to: expression.count - 1, by: 2) {
            let operatorIndex = expression.index(expression.startIndex, offsetBy: index)
            let leftRange = expression.startIndex ... expression.index(before: operatorIndex)
            let rightRange = expression.index(after: operatorIndex) ..< expression.endIndex
            
            let operatorBetweenParentheses = String(expression[operatorIndex])
            let leftParenthesizedExpression = String(expression[leftRange])
            let rightParenthesizedExpression = String(expression[rightRange])
            
            let leftResult = try countValidParenthesesPositions(expression: leftParenthesizedExpression, lookup: &lookup)
            let rightResult = try countValidParenthesesPositions(expression: rightParenthesizedExpression, lookup: &lookup)
            
            var result: (trueCount: Int, falseCount: Int) = (0, 0)
            let totalCount = (leftResult.trueCount + leftResult.falseCount) * (rightResult.trueCount + rightResult.falseCount)
            
            switch operatorBetweenParentheses {
            case "|":
                result.trueCount = leftResult.trueCount * rightResult.trueCount + leftResult.trueCount * rightResult.falseCount + leftResult.falseCount * rightResult.trueCount
            case "&":
                result.trueCount = leftResult.trueCount * rightResult.trueCount
            case "^":
                result.trueCount = leftResult.trueCount * rightResult.falseCount + leftResult.falseCount * rightResult.trueCount
            default:
                throw NSError(domain: "Unsupported operator!", code: 0, userInfo: nil)
            }
            
            result.falseCount = totalCount - result.trueCount
            
            cumulatedResult.trueCount += result.trueCount
            cumulatedResult.falseCount += result.falseCount
        }
        
        lookup[expression] = cumulatedResult
        
        return cumulatedResult
    }
}

extension String {
    func toBool() -> Bool {
        return self == "1" ? true : false
    }
}
