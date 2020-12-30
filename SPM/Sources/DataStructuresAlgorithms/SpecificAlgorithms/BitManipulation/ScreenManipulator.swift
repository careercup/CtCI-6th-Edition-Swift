//
//  ScreenManipulator.swift
//  
//
//  Created by Stefan Jaindl on 03.08.20.
//

import Foundation

open class ScreenManipulator {
    public init() { }
    
    //width + coordinates in bits. Screen is stored in whole bytes.
    //screen width is divisible by 8.
    open func drawLine(screen: inout [UInt8], width: Int, x1: Int, x2: Int, y: Int) {
        let height = screen.count / (width / 8)
        if y >= height {
            return
        }
        
        let startByte = y * width / 8 + x1 / 8
        let endByte = startByte + (x2 - x1) / 8
        
        if startByte == endByte {
            //horizontal line within same byte
            var ones = x2 - x1
            var mask: UInt8 = 0b1
            while ones > 0 {
                mask = mask << 1 | 1
                ones -= 1
            }
            mask <<= 8 - 1 - x2
            screen[startByte] = mask
        } else {
            var start: UInt8 = 0xFF
            let startRemainder = x1 % 8
            start >>= startRemainder
            
            var end: UInt8 = 0xFF
            let endRemainder = x2 % 8
            end >>= 8 - endRemainder
            end <<= 8 - endRemainder
            
            screen[startByte] = start
            for index in startByte + 1 ..< endByte {
                screen[index] = 0xFF
            }
            screen[endByte] = end
        }
    }
}
