//
//  XMLEncoder.swift
//  
//
//  Created by Stefan Jaindl on 23.11.20.
//

import Foundation

public enum XMLElement {
    case tag(encoded: Int)
    case end
    case value(value: String)
}

open class XMLEncoder {
    public init() { }
    
    private let endEncoding = "0"
    
    open func encode(xml: String, attributesMapping: [String: Int]) throws -> String {
        guard !xml.isEmpty else {
            return ""
        }
        
        let elements = try buildElements(xml: xml, attributesMapping: attributesMapping)
        let encoded = encode(elements: elements)
        
        return encoded
    }
    
    private func buildElements(xml: String, attributesMapping: [String: Int]) throws -> [XMLElement] {
        var remainingXml = xml
        var elements: [XMLElement] = []
        
        while !remainingXml.isEmpty {
            //First, search for string enclosed in < .. >
            guard let elementOpenIndex = remainingXml.firstIndex(of: "<"), let closeIndex = remainingXml.firstIndex(of: ">") else {
                throw NSError(domain: "XMLEncoder: Invalid XML", code: 0, userInfo: nil)
            }
            
            let elementCloseIndex = remainingXml.index(after: closeIndex)
            let element = String(remainingXml[elementOpenIndex ..< elementCloseIndex])
            remainingXml = String(remainingXml[elementCloseIndex ..< remainingXml.endIndex])
            
            let subElements = element.split(separator: " ")
            try subElements.forEach { subElement in
                let endsWithClosing = subElement[subElement.index(before: subElement.endIndex)] == ">"
                
                if subElement.starts(with: "</"), endsWithClosing {
                    elements.append(.end)
                } else if subElement.starts(with: "<") {
                    let startAttribute = String(subElement[subElement.index(after: subElement.startIndex) ..< subElement.endIndex])
                    guard let encoding = attributesMapping[startAttribute] else {
                        throw NSError(domain: "XMLEncoder: Missing mapping for \(startAttribute)", code: 0, userInfo: nil)
                    }
                    
                    elements.append(.tag(encoded: encoding))
                }
                
                if subElement.contains("=") {
                    let attribute = subElement.split(separator: "=")
                    guard attribute.count == 2 else {
                        throw NSError(domain: "XMLEncoder: Invalid XML attribute", code: 0, userInfo: nil)
                    }
                    
                    let tag = String(attribute[0])
                    let tagValue = String(attribute[1].trimmingCharacters(in: CharacterSet(arrayLiteral: ">")).trimmingCharacters(in: CharacterSet(arrayLiteral: "\"")))
                    
                    guard let encoding = attributesMapping[tag] else {
                        throw NSError(domain: "XMLEncoder: Missing mapping for \(tag)", code: 0, userInfo: nil)
                    }
                    
                    elements.append(.tag(encoded: encoding))
                    elements.append(.value(value: tagValue))
                }
                
                if endsWithClosing, let possibleValueIndex = remainingXml.firstIndex(of: "<") {
                    let value = remainingXml[remainingXml.startIndex ..< possibleValueIndex].trimmingCharacters(in: CharacterSet(arrayLiteral: " "))
                    if !value.isEmpty {
                        elements.append(.value(value: value))
                    }
                }
            }
        }
        
        return elements
    }
    
    private func encode(elements: [XMLElement]) -> String {
        var encodedString = ""
        
        elements.forEach { element in
            switch element {
            case .tag(let encoded):
                encodedString.append(" \(encoded)")
            case .end:
                encodedString.append(" \(endEncoding)")
            case .value(value: let value):
                encodedString.append(" \(value)")
            }
        }
        
        return encodedString.trimmingCharacters(in: CharacterSet(arrayLiteral: " "))
    }
}
