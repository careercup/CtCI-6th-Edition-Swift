//
//  MedianKeeper.swift
//  
//
//  Created by Stefan Jaindl on 12.12.20.
//

import Foundation

open class MedianKeeper<T: BinaryInteger> {
    public init() { }
    
    open func median(of values: [T]) throws -> T? {
        guard !values.isEmpty else {
            return nil
        }
        
        if values.count == 1 {
            return values[0]
        }
        
        let upperRangeHeap = MinHeap<T>() //stores larger half of elements
        let lowerRangeHeap = MaxHeap<T>() //stores smaller half of elements
        
        for value in values {
            if upperRangeHeap.isEmpty(), lowerRangeHeap.isEmpty() {
                upperRangeHeap.insert(val: value)
                continue
            } else if lowerRangeHeap.isEmpty() {
                //exactly 1 element in min heap
                if try value > upperRangeHeap.peekMin() {
                    let min = try upperRangeHeap.extractMin()
                    upperRangeHeap.insert(val: value)
                    lowerRangeHeap.insert(val: min)
                } else {
                    lowerRangeHeap.insert(val: value)
                }
            } else { //both heaps contain elements
                if try value > upperRangeHeap.peekMin() {
                    //store in upper range
                    if upperRangeHeap.numberOfElements() > lowerRangeHeap.numberOfElements() {
                        let min = try upperRangeHeap.extractMin()
                        upperRangeHeap.insert(val: value)
                        lowerRangeHeap.insert(val: min)
                    } else {
                        upperRangeHeap.insert(val: value)
                    }
                } else {
                    //store in lower range
                    if lowerRangeHeap.numberOfElements() > upperRangeHeap.numberOfElements() {
                        let max = try lowerRangeHeap.extractMax()
                        lowerRangeHeap.insert(val: value)
                        upperRangeHeap.insert(val: max)
                    } else {
                        lowerRangeHeap.insert(val: value)
                    }
                }
            }
        }
        
        if lowerRangeHeap.numberOfElements() == upperRangeHeap.numberOfElements() {
            let lower = try lowerRangeHeap.peekMax()
            let upper = try upperRangeHeap.peekMin()
            
            return (lower + upper) / 2
        } else if lowerRangeHeap.numberOfElements() < upperRangeHeap.numberOfElements() {
            return try upperRangeHeap.peekMin()
        } else {
            return try lowerRangeHeap.peekMax()
        }
    }
}
