//
//  IntToEnglishString.swift
//  
//
//  Created by Stefan Jaindl on 19.11.20.
//

import Foundation

open class IntToEnglishString {
    
    public init() { }
    
    private enum Config: CaseIterable {
        case ones
        case tens
        case hundred
        case thousand
        case tenthousand
        case hundredthousand
        case million
        case tenmillion
        case hundredmillion
        case billion
    }
    
    private let ones: [Int: String] = [
        0: "",
        1: "One",
        2: "Two",
        3: "Three",
        4: "Four",
        5: "Five",
        6: "Six",
        7: "Seven",
        8: "Eight",
        9: "Nine"
    ]
    
    private let tens: [Int: String] = [
        0: "",
        1: "Ten",
        2: "Twenty",
        3: "Thirty",
        4: "Fourty",
        5: "Fifty",
        6: "Sixty",
        7: "Seventy",
        8: "Eighty",
        9: "Ninety"
    ]
    
    private let specialTens: [Int: String] = [
        0: "Ten",
        1: "Eleven",
        2: "Twelve",
        3: "Thirteen",
        4: "Fourteen",
        5: "Fifteen",
        6: "Sixteen",
        7: "Seventeen",
        8: "Eighteen",
        9: "Nineteen"
    ]
    
    private let zero = "Zero"
    private let hundred = "Hundred"
    private let thousand = "Thousand"
    private let million = "Million"
    private let billion = "Billion"
    
    open func convertToEnglishString(number: Int) throws -> String {
        let stack = Stack<String>()
        
        var convertedString = ""
        var curNumber = number
        let order = Config.allCases
        var orderIndex = 0
        var thousandAppended = false
        var millionAppended = false
        
        while curNumber > 0 {
            let currentDigit = curNumber % 10
            let place = order[orderIndex]
            var valueOfPlace: String
            
            switch place {
            case .ones:
                valueOfPlace = ones[currentDigit] ?? ""
            case .tens:
                valueOfPlace = try tens(with: "", stack: stack, currentDigit: currentDigit)
            case .hundred:
                valueOfPlace = digit(with: hundred, stack: stack, currentDigit: currentDigit)
            case .thousand:
                valueOfPlace = digit(with: thousand, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty {
                    thousandAppended = true
                }
            case .tenthousand:
                valueOfPlace = try tens(with: thousandAppended ? "" : thousand, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty {
                    thousandAppended = true
                }
            case .hundredthousand:
                valueOfPlace = digit(with: hundred, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty, !thousandAppended {
                    valueOfPlace.append(" \(thousand)")
                }
            case .million:
                valueOfPlace = digit(with: million, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty {
                    millionAppended = true
                }
            case .tenmillion:
                valueOfPlace = try tens(with: millionAppended ? "" : million, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty {
                    millionAppended = true
                }
            case .hundredmillion:
                valueOfPlace = digit(with: hundred, stack: stack, currentDigit: currentDigit)
                if !valueOfPlace.isEmpty, !millionAppended {
                    valueOfPlace.append(" \(million)")
                }
            case .billion:
                valueOfPlace = digit(with: billion, stack: stack, currentDigit: currentDigit)
            }
            
            stack.push(val: valueOfPlace)
            
            orderIndex += 1
            curNumber /= 10
        }
        
        while !stack.isEmpty() {
            convertedString = "\(convertedString) \(try stack.pop())".trimmingCharacters(in: CharacterSet(arrayLiteral: " "))
        }
        
        return convertedString.isEmpty ? zero : convertedString
    }
    
    private func tens(with appended: String, stack: Stack<String>, currentDigit: Int) throws -> String {
        guard var valueOfPlace = tens[currentDigit] else {
            return ""
        }
        
        if valueOfPlace == tens[1] {
            let onesPlace = try stack.pop()
            if !onesPlace.isEmpty, let value = ones.filter({ $0.value == onesPlace }).first {
                valueOfPlace = specialTens[value.key] ?? ""
            } else {
                valueOfPlace = valueOfPlace.trimmingCharacters(in: CharacterSet(arrayLiteral: " "))
                valueOfPlace.append(" \(appended)")
            }
        }
        
        return valueOfPlace
    }
    
    private func digit(with appended: String, stack: Stack<String>, currentDigit: Int) -> String {
        guard var valueOfPlace = ones[currentDigit] else {
            return ""
        }
        
        if !valueOfPlace.isEmpty, !appended.isEmpty {
            valueOfPlace.append(" \(appended)")
        }
        
        return valueOfPlace
    }
}
