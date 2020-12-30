//
//  NodeIntersection.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 10.06.20.
//

import Foundation

open class NodeIntersection<T: Comparable> {
    
    public init() { }
    
    open func intersect(first: SingleLinkedList<T>, second: SingleLinkedList<T>) -> SingleNode<T>? {
        if first.isEmpty() || second.isEmpty() {
            return nil
        }
        
        guard let firstIntersection = getIntersectionWrapper(linkedList: first), let secondIntersection = getIntersectionWrapper(linkedList: second) else {
            return nil
        }
        
        //compare by reference
        if firstIntersection.lastNode !== secondIntersection.lastNode {
            return nil
        }
        
        var firstNode = node(linkedList: first, offset: max(0, firstIntersection.count - secondIntersection.count))
        var secondNode = node(linkedList: second, offset: max(0, secondIntersection.count - firstIntersection.count))
        
        while firstNode != nil, secondNode != nil {
            if firstNode === secondNode {
                return firstNode
            }
            
            firstNode = firstNode?.next
            secondNode = secondNode?.next
        }
        
        return nil
    }
    
    func getIntersectionWrapper(linkedList: SingleLinkedList<T>) -> IntersectionWrapper<T>? {
        var count = 0
        var curNode = linkedList.head
        
        while curNode?.next != nil {
            count += 1
            curNode = curNode?.next
        }
        
        if let curNode = curNode {
            return IntersectionWrapper(count: count, lastNode: curNode)
        }
        return nil
    }
    
    func node(linkedList: SingleLinkedList<T>, offset: Int) -> SingleNode<T>? {
        var node = linkedList.head
        var index = 0
        while index < offset, node != nil {
            node = node?.next
            index += 1
        }
        
        return node
    }
}

public struct IntersectionWrapper<T: Comparable> {
    var count: Int
    var lastNode: SingleNode<T>
}
