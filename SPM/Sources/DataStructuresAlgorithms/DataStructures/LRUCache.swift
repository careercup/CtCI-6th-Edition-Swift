//
//  LRUCache.swift
//  
//
//  Created by Stefan Jaindl on 01.12.20.
//

import Foundation

open class LRUCache<T: Hashable> {
    
    private let cacheSize: Int
    private var currentCount = 0
    private var cache = DoubleLinkedList<T>()
    private var lookup = [T: Node<T>]()
    
    public init(cacheSize: Int) {
        self.cacheSize = cacheSize
    }
    
    open func insert(_ value: T) {
        if let node = get(value) {
            node.val = value
            
            //Promote node to top of cache
            guard node != cache.tail else {
                return //already at top of cache
            }
            
            promote(node: node)
            
            return
        }
        
        if isFull() {
            removeHead()
        }
        
        updateCache(with: Node(val: value))
        currentCount += 1
    }
    
    open func get(_ value: T) -> Node<T>? {
        guard let node = lookup[value] else {
            return nil
        }
        
        promote(node: node)
        
        return node
    }
    
    private func promote(node: Node<T>) {
        let nextNode = node.next
        node.prev?.next = nextNode
        nextNode?.prev = node.prev
        
        node.next = nil
        node.prev = cache.tail
        cache.tail?.next = node
        
        cache.tail = node
    }
    
    private func removeHead() {
        guard let node = cache.head else {
            return
        }
        
        lookup.removeValue(forKey: node.val)
        
        let newHead = cache.head?.next
        newHead?.prev = nil
        cache.head?.next = nil
        cache.head = newHead
        
        currentCount -= 1
    }
    
    private func updateCache(with node: Node<T>) {
        if currentCount == 0 {
            cache.head = node
            cache.tail = node
        } else if currentCount == 1 {
            cache.tail = node
            node.prev = cache.head
            cache.head?.next = node
        } else {
            cache.tail?.next = node
            node.prev = cache.tail
            cache.tail = node
        }
        
        lookup[node.val] = node
    }
    
    private func isFull() -> Bool {
        return currentCount == cacheSize
    }
}
