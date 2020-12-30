//
//  MinStack.swift
//  
//
//  Created by Stefan Jaindl on 18.06.20.
//

import Foundation

open class MinStack<T: Comparable> {
    private var head: MinStackNode<T>?
    private var size: Int = 0
    
    open func push(value: T) {
        let minValueSubstack = Swift.min(value, head?.minValueSubstack ?? value)
        let newHead = MinStackNode(value: value, next: head, minValueSubstack: minValueSubstack)
        head = newHead
        size += 1
    }
    
    open func pop() throws -> T {
        guard let node = head else {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        head = node.next
        size -= 1
        return node.value
    }
    
    open func isEmpty() -> Bool {
        return size == 0
    }
    
    open func min() throws -> T {
        guard let head = head else {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        return head.minValueSubstack
    }
}

private class MinStackNode<T: Comparable> {
    var value: T
    var next: MinStackNode<T>?
    var minValueSubstack: T
    
    init(value: T, next: MinStackNode<T>?, minValueSubstack: T) {
        self.value = value
        self.next = next
        self.minValueSubstack = minValueSubstack
    }
}
