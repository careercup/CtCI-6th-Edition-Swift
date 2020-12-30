//
//  MinStack.swift
//  
//
//  Created by Stefan Jaindl on 18.06.20.
//

import Foundation

open class QueueWithStacks<T: Comparable & Hashable> {
    private var firstStack = Stack<T>()
    private var secondStack = Stack<T>()
    
    public init() { }
    
    open func enqueue(value: T) throws {
        firstStack.push(val: value)
    }
    
    open func dequeue() throws -> T {
        if firstStack.isEmpty() && secondStack.isEmpty() {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        moveElements(from: firstStack, to: secondStack)
        
        return try secondStack.pop()
    }
    
    open func isEmpty() -> Bool {
        return firstStack.isEmpty() && secondStack.isEmpty()
    }
    
    private func moveElements(from: Stack<T>, to: Stack<T>) {
        while !from.isEmpty(), let node = try? from.pop() {
            to.push(val: node)
        }
    }
}
