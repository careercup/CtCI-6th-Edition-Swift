//
//  BinaryNearbySearcher.swift
//  
//
//  Created by Stefan Jaindl on 29.07.20.
//

import Foundation

open class BinaryNearbySearcher {
    public init() { }
    
    private enum SearchType {
        case smaller, bigger
    }
    
    //Returns next smaller (if existing) and next bigger number with the same amount of 1 bits in its binary representation
    public func nearestBinaryNumbers(number: Int) -> (Int?, Int?) {
        let smaller = nearest(number: number, type: .smaller)
        let bigger = nearest(number: number, type: .bigger)
        
        return (bigger, smaller)
    }
    
    private func nearest(number: Int, type: SearchType) -> Int? {
        var runningMask = 0b1
        var lastRight = 0b0
        var right = 0b0
        var shiftedCount = 0
        var nonTrailingFound = false
        var nonTrailingCount = 0
        var found = false
        
        if number == 0 {
            //nearest not existing
            return nil
        }
        
        while !found {
            if runningMask > (number << 1) {
                //nearest not existing
                return nil
            }
            
            let result = number & runningMask
            
            switch type {
            case .smaller:
                if result == 0 {
                    if nonTrailingFound {
                        nonTrailingCount += 1
                    }
                    nonTrailingFound = true
                } else if nonTrailingFound {
                    found = true
                }
            case .bigger:
                if result > 0 {
                    if nonTrailingFound {
                        nonTrailingCount += 1
                    }
                    nonTrailingFound = true
                } else if nonTrailingFound {
                    found = true
                }
            }
            
            shiftedCount += 1
            runningMask <<= 1
            
            if !found {
                lastRight = right
                right |= result
            } else {
                right = lastRight
            }
        }
        
        var result = number >> shiftedCount
        
        result <<= 1
        if type == .bigger {
            result |= 0b1
        }
        
        result <<= 1
        if type == .smaller {
            result |= 0b1
        }
        
        result <<= shiftedCount - 2
        
        if type == .bigger {
            while right > 0, right & 0b1 == 0 {
                right >>= 1
            }
        } else if type == .smaller {
            right <<= nonTrailingCount
        }
        
        return result | right
    }
}
