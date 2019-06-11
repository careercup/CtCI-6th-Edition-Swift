//
//  RandomIntegerExtensions.swift
//
//  Created by Matthew Carroll on 8/17/16.
//  Copyright © 2016 Matthew Carroll. All rights reserved.
//

import Foundation

public extension String {
    
    init(randomLettersOfCount count: Int) {
        let firstAsciiValue: UInt8 = 97
        let lastAsciiValue: UInt8 = 122
        let asciiRange = firstAsciiValue...lastAsciiValue
        let charCount = 0..<count
        let characters = charCount.map { _ -> Character in
            let codeUnit = UInt8.random(in: asciiRange)
            return Character(UnicodeScalar(codeUnit))
        }
        self = String(characters)
    }
}
