//
//  Queue.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 23.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class Queue<T: Hashable> {
    private var items: [Node<T>?]
    private var capacity: Int = 10
    private var nextPos: Int = 0
    private var frontPos: Int = 0
    public var size: Int = 0
    
    public init() {
        items = [Node<T>?](repeating: nil, count: capacity)
    }
    
    open func enqueue(val: T) {
        if size == items.count {
            resizeArray(newSize: size * 2)
        }
        
        if nextPos == items.count {
            rebuildArray()
        }
        
        let node = Node<T>(val: val)
        items[nextPos] = node
        size += 1
        nextPos += 1
    }
    
    open func dequeue() throws -> T {
        if size == 0 {
            throw NSError(domain: "No element in queue", code: 0, userInfo: nil)
        }
        
        if items.count < size / 4 {
            resizeArray(newSize: size / 4)
        }
        
        let item = items[frontPos]
        frontPos += 1
        size -= 1
        
        return item!.val
    }
    
    open func isEmpty() -> Bool {
        return size == 0
    }
    
    private func rebuildArray() {
        var newArr = [Node<T>?] (repeating: nil, count: items.count)
        for n in frontPos ... nextPos {
            newArr.append(items[n])
        }
        items = newArr
        nextPos -= frontPos
        frontPos = 0
    }
    
    private func resizeArray(newSize: Int) {
        var newArr = [Node<T>?] (repeating: nil, count: newSize)
        for n in frontPos ... nextPos {
            newArr.append(items[n])
        }
        items = newArr
        nextPos -= frontPos
        frontPos = 0
        size = newSize
    }
}
