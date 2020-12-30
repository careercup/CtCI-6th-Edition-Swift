//
//  StackSet.swift
//  
//
//  Created by Stefan Jaindl on 21.06.20.
//

import Foundation

open class StackSet<T: Comparable> {
    private var totalElements = 0
    private let treshold: Int
    private var stacks: [SingleStack<T>] = []
    
    public init(treshold: Int) {
        self.treshold = treshold
        
        stacks.append(SingleStack<T>(capacity: treshold))
    }
    
    open func isEmpty() -> Bool {
        return totalElements == 0
    }
    
    open func push(element: T) throws {
        var stack = lastStack()
        
        if stack.isFull() {
            stack = addStack()
        }
        
        try stack.push(element: element)
        
        totalElements += 1
    }
    
    open func pop() throws -> T {
        if isEmpty() {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        let value = try lastStack().pop()
        resizeStacks()
        totalElements -= 1
        
        return value
    }
    
    open func pop(at index: Int) throws -> T {
        if index < 0 || index >= stacks.count {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        let value = try stacks[index].pop()
        try moveLeft(from: index)
        totalElements -= 1
        
        return value
    }
    
    private func lastStack() -> SingleStack<T> {
        stacks.count > 1 && stacks[stacks.count - 1].isEmpty() ? stacks[stacks.count - 2] : stacks[stacks.count - 1]
    }
    
    private func addStack() -> SingleStack<T> {
        stacks.append(SingleStack<T>(capacity: treshold))
        return stacks[stacks.count - 1]
    }
    
    private func resizeStacks() {
        guard stacks.count > 1 else {
            return
        }
        
        if stacks[stacks.count - 1].isEmpty() && stacks[stacks.count - 2].isEmpty() {
            stacks.removeLast()
        }
    }
    
    private func moveLeft(from index: Int) throws {
        var currentIndex = index
        
        while currentIndex + 1 < stacks.count {
            let firstStack = stacks[currentIndex]
            let secondStack = stacks[currentIndex + 1]
            
            var secondStackIndex = 0
            
            while !firstStack.isFull(), secondStackIndex < secondStack.capacity, let element = secondStack.array[secondStackIndex] {
                try firstStack.push(element: element)
                secondStack.array[secondStackIndex] = nil
                secondStack.numElements -= 1
                secondStackIndex += 1
            }
            
            moveNonNullValuesToBeginning(of: secondStack)
            currentIndex += 1
        }
    }
    
    private func moveNonNullValuesToBeginning(of stack: SingleStack<T>) {
        //move non-null values of array to beginning
        if stack.array[0] == nil {
            var backIndex = 0
            while backIndex < stack.array.count, stack.array[backIndex] == nil {
                backIndex += 1
            }
            
            var frontIndex = 0
            while backIndex < stack.capacity - 1 {
                stack.array[frontIndex] = stack.array[backIndex]
                stack.array[backIndex] = nil
                frontIndex += 1
                backIndex += 1
            }
            
            while stack.array[stack.array.count - 1] == nil {
                stack.array.removeLast()
            }
        }
    }
}

private class SingleStack<T: Comparable> {
    var numElements: Int = 0
    let capacity: Int
    var array: [T?] = []
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func isFull() -> Bool {
        return numElements == capacity
    }
    
    func isEmpty() -> Bool {
        return numElements == 0
    }
    
    func push(element: T) throws {
        if isFull() {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        array.append(element)
        numElements += 1
    }
    
    func pop() throws -> T {
        guard !isEmpty(), let value = array[numElements - 1] else {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        array.removeLast()
        numElements -= 1
        
        return value
    }
}
