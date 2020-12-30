//
//  Calculator.swift
//  
//
//  Created by Stefan Jaindl on 01.12.20.
//

import Foundation

open class Calculator {
    let tempStack = Stack<Double>()
    let resultStack = Stack<Double>()
    
    public init() { }
    
    open func calculate(expressions: [Expression]) throws -> Double {
        guard !expressions.isEmpty else {
            return 0.0
        }
        
        var lastOperator: Expression?
        
        try expressions.forEach { expression in
            switch expression {
            case .operand(let number):
                try handleOperand(number: number, lastOperator: lastOperator)
            case .plus:
                lastOperator = .plus
                try handlePlus()
            case .minus:
                lastOperator = .minus
                try handleMinus()
            case .divide:
                lastOperator = .divide
            case .multiply:
                lastOperator = .multiply
            }
        }
        
        if !tempStack.isEmpty() {
            let lastElement = try tempStack.pop()
            let lastResult = try resultStack.pop()
            resultStack.push(val: lastElement + lastResult)
        }
        
        return try resultStack.pop()
    }
    
    private func handleOperand(number: Double, lastOperator: Expression?) throws {
        if tempStack.isEmpty() {
            tempStack.push(val: number)
        } else if let lastOperator = lastOperator {
            switch lastOperator {
            case .multiply:
                let firstOperand = try tempStack.pop()
                tempStack.push(val: number * firstOperand)
            case .divide:
                let firstOperand = try tempStack.pop()
                tempStack.push(val: firstOperand / number)
            case .plus:
                tempStack.push(val: number)
            case .minus:
                tempStack.push(val: -number)
            case .operand(_):
                throw NSError(domain: "Invalid Input", code: 0, userInfo: nil)
            }
        }
    }
    
    private func handlePlus() throws {
        if !tempStack.isEmpty() {
            let lastResult = try tempStack.pop()
            if !resultStack.isEmpty() {
                let resultSoFar = try resultStack.pop()
                resultStack.push(val: resultSoFar + lastResult)
            } else {
                resultStack.push(val: lastResult)
            }
        }
    }
    
    private func handleMinus() throws {
        if !tempStack.isEmpty() {
            let lastResult = try tempStack.pop()
            if !resultStack.isEmpty() {
                let resultSoFar = try resultStack.pop()
                resultStack.push(val: resultSoFar - lastResult)
            } else {
                resultStack.push(val: lastResult)
            }
        }
    }
}

extension Calculator {
    public enum Expression {
        case operand(Double)
        case plus
        case minus
        case divide
        case multiply
    }
}
