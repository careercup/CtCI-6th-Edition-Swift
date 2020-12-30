//
//  RandomSet.swift
//  
//
//  Created by Stefan Jaindl on 04.12.20.
//

import Foundation

open class RandomSet<T> {
    public init() { }
    
    open func randomSet(of size: Int, from array: [T]) -> [T] {
        guard size > 0, !array.isEmpty, size < array.count else {
            return []
        }
        
        var randomSet: [T] = []
        
        for (index, element) in array.enumerated() {
            if index < size {
                //fill up array
                randomSet.append(element)
            } else {
                let random = Int.random(in: 0 ..< index)
                if random < size {
                    //replace element
                    randomSet[random] = element
                }
            }
        }
        
        return randomSet
    }
}
