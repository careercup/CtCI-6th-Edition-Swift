//
//  MaxHeap.swift
//  
//
//  Created by Stefan Jaindl on 11.12.20.
//

import Foundation

open class MaxHeap<T: Comparable> {
    private var array = [T] ()
    
    public init() { }
    
    open func insert(val: T) {
        array.append(val)
        swim(key: array.count - 1)
    }
    
    open func peekMax() throws -> T {
        if array.count < 1 {
            throw NSError(domain: "Heap: no elements in heap", code: 0, userInfo: nil)
        }
        
        return array[0]
    }
    
    @discardableResult
    open func extractMax() throws -> T {
        let max = try peekMax()
        array[0] = array[array.count - 1]
        array.removeLast()
        sink(key: 0)
        
        return max
    }
    
    open func isEmpty() -> Bool {
        return array.isEmpty
    }
    
    open func numberOfElements() -> Int {
        return array.count
    }
    
    private func swim(key: Int) {
        if array[key] > array[(key-1) / 2] {
            exchange(index1: key, index2: ((key - 1) / 2))
            swim(key: (key - 1) / 2)
        }
    }
    
    private func sink(key: Int) {
        let key1Index = 2 * key + 1
        let key2Index = 2 * key + 2
        
        if array.count - 1 >= key2Index &&
            array[key] < max(array[key1Index], array[key2Index]) {
            if array[key1Index] < array[key2Index] {
                exchange(index1: key, index2: key2Index)
                sink(key: key2Index)
            } else {
                exchange(index1: key, index2: key1Index)
                sink(key: key1Index)
            }
        } else if array.count - 1 >= key1Index &&
            array[key] < array[key1Index] {
            exchange(index1: key, index2: key1Index)
            sink(key: key1Index)
        }
    }
    
    private func exchange(index1: Int, index2: Int) {
        let temp = array[index1]
        array[index1] = array[index2]
        array[index2] = temp
    }
}
