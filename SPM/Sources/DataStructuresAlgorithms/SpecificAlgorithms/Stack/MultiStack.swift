//
//  MultiStack.swift
//  
//
//  Created by Stefan Jaindl on 14.06.20.
//

import Foundation

open class MultiStack<T> {
    
    private var numberOfStacks: Int
    private var stackInfo: [StackInfo] = []
    private var array: [T?]
    private var totalElements: Int
    
    public init(numberOfStacks: Int, len: Int) {
        self.numberOfStacks = numberOfStacks
        stackInfo.reserveCapacity(numberOfStacks)
        
        let baseCapacity = len / numberOfStacks
        let remainder = len % numberOfStacks
        for stackNumber in 0 ..< numberOfStacks {
            let index = stackNumber * len / numberOfStacks
            let stackCapacity = stackNumber == numberOfStacks - 1 ? baseCapacity + remainder : baseCapacity
            stackInfo.append(StackInfo(numberOfElements: 0, capacity: stackCapacity, startIndex: index))
        }
        
        array = [T?](repeating: nil, count: len)
        totalElements = 0
    }
    
    open func isEmpty(stackNumber: Int) -> Bool {
        return stackInfo[stackNumber].numberOfElements == 0
    }
    
    open func peek(stackNumber: Int) throws -> T {
        if isEmpty(stackNumber: stackNumber) {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        guard let element = array[lastIndex(stackNumber: stackNumber)] else {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        return element
    }
    
    open func pop(stackNumber: Int) throws -> T {
        let element = try peek(stackNumber: stackNumber)
        
        stackInfo[stackNumber].numberOfElements -= 1
        
        totalElements -= 1
        
        return element
    }
    
    open func push(stackNumber: Int, element: T) throws {
        if totalElements == array.count {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        let info = stackInfo[stackNumber]
        
        if info.isFull() {
            decreaseCapacity(stackNumber: (stackNumber + 1) % numberOfStacks)
            info.capacity += 1
        }
        
        let index = currentIndex(stackNumber: stackNumber)
        array[index] = element
        info.numberOfElements += 1
        
        totalElements += 1
    }
    
    private func decreaseCapacity(stackNumber: Int) {
        if stackInfo[stackNumber].isFull() {
            decreaseCapacity(stackNumber: (stackNumber + 1) % numberOfStacks)
            stackInfo[stackNumber].capacity += 1
            shiftRight(stackNumber: stackNumber)
            stackInfo[stackNumber].startIndex += 1
            stackInfo[stackNumber].capacity -= 1
        } else {
            shiftRight(stackNumber: stackNumber)
            stackInfo[stackNumber].startIndex += 1
            stackInfo[stackNumber].capacity -= 1
        }
    }
    
    private func shiftRight(stackNumber: Int) {
        if isEmpty(stackNumber: stackNumber) {
            return
        }
        
        var index = lastIndex(stackNumber: stackNumber)
        while index >= stackInfo[stackNumber].startIndex {
            let nextIndex = index + 1
            array[nextIndex] = array[index]
            index -= 1
        }
    }
    
    private func lastIndex(stackNumber: Int) -> Int {
        return stackInfo[stackNumber].lastIndex % array.count
    }
    
    private func currentIndex(stackNumber: Int) -> Int {
        return stackInfo[stackNumber].currentIndex % array.count
    }
}

private class StackInfo {
    var numberOfElements: Int
    var capacity: Int
    var startIndex: Int
    
    init(numberOfElements: Int, capacity: Int, startIndex: Int) {
        self.numberOfElements = numberOfElements
        self.capacity = capacity
        self.startIndex = startIndex
    }
    
    var currentIndex: Int {
        return startIndex + numberOfElements
    }
    
    var lastIndex: Int {
        return startIndex + numberOfElements - 1
    }
    
    func isFull() -> Bool {
        return numberOfElements == capacity
    }
}
