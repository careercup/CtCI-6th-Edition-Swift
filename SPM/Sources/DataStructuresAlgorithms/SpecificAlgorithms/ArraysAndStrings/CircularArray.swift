//
//  CircularArray.swift
//  
//
//  Created by Stefan Jaindl on 10.08.20.
//

import Foundation

open class CircularArray<T> {
    public init (array: [T]) {
        self.array = array
    }
    
    let array: [T]
    var startIndex = 0
    var endIndex: Int {
        return startIndex == 0 ? array.count : startIndex - 1
    }
    
    open func isEmpty() -> Bool {
        return array.count == 0
    }
    
    open func rightRotate(by: Int) {
        startIndex = (startIndex - by) % array.count
        if startIndex < 0 {
            startIndex += array.count
        }
    }
    
    open func leftRotate(by: Int) {
        startIndex = (startIndex + by) % array.count
    }
}

extension CircularArray: Sequence {
    public func makeIterator() -> CircularArrayIterator<T> {
        return CircularArrayIterator<T>(array: array, startIndex: startIndex)
    }
}

open class CircularArrayIterator<T>: IteratorProtocol {
    let array: [T]
    var startIndex: Int
    var currentIndex: Int
    var previousIndex: Int
    
    init(array: [T], startIndex: Int) {
        self.array = array
        self.startIndex = startIndex
        currentIndex = startIndex
        previousIndex = -1
    }
    
    open func next() -> T? {
        guard hasNext() else {
            return nil
        }
        
        let element = array[currentIndex]
        previousIndex = currentIndex
        currentIndex = (currentIndex + 1) % array.count
        
        return element
    }
    
    private func hasNext() -> Bool {
        return previousIndex == -1 || currentIndex != startIndex
    }
}
