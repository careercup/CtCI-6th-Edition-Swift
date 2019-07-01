//
//  RandomIntegerExtensions.swift
//
//  Created by Matthew Carroll on 8/17/16.
//  Copyright © 2016 Matthew Carroll. All rights reserved.
//

import Foundation

public extension Array where Element: FixedWidthInteger {
    
    init(randomInUpperBound bound: Int, randomIntCount: Int, negativeValues: Bool = false) {
        self = []
        let range: Range<Element> = 0..<numericCast(bound)
        for _ in 0..<randomIntCount {
            let randomInt = Element.random(in: range)
            append(randomInt)
        }
        if negativeValues {
            let negativeCount = Int.random(in: 0...count)
            for _ in 0..<negativeCount {
                let i = Int.random(in: 0..<count)
                self[i] *= -1
            }
        }
    }
}
