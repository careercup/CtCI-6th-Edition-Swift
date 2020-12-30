//
//  BTree.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 18.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class BTreeNode<T: Comparable & Hashable> {
    
    public var degree: Int
    
    public var numberOfKeys: Int
    public var numberOfChilds: Int
    
    public var keys: [T?]
    public var childNodes: [BTreeNode?]
    
    private var maxKeys: Int {
        return 2 * degree - 1
    }
    
    private var maxChilds: Int {
        return 2 * degree
    }
    
    public init(degree: Int) {
        self.degree = degree
        numberOfKeys = 0
        numberOfChilds = 0
        keys = [T?] (repeatElement(nil, count: 2 * degree - 1))
        childNodes = [BTreeNode?] (repeatElement(nil, count: 2 * degree))
    }
    
    open func traverse(stack: inout Stack<T>) {
        //inorder traversal
        for keyIndex in 0 ... numberOfKeys { // numberOfChilds can be one greater than numberOfKeys
            childNodes[keyIndex]?.traverse(stack: &stack)
            if let key = keys[keyIndex] {
                stack.push(val: key)
            }
        }
    }
    
    open func search(key: T) -> Bool {
        for nodeIndex in 0 ... numberOfKeys { // numberOfChilds can be one greater than numberOfKeys
            if let child = childNodes[nodeIndex], child.search(key: key) {
                return true
            }
            
            if let keyAtIndex = keys[nodeIndex] {
                if keyAtIndex == key {
                    return true
                }
            }
        }
        
        return false
    }
    
    open func isLeafNode() -> Bool {
        return numberOfChilds == 0
    }
    
    open func isFull() -> Bool {
        return numberOfKeys == maxKeys
    }
    
    open func insert(key: T) throws {
        if numberOfKeys == 0 {
            try insert(key: key, at: 0)
        } else {
            for index in 0 ... numberOfKeys {
                if let keyAtIndex = keys[index], keyAtIndex > key {
                    try insert(key: key, at: index - 1)
                    return
                }
            }
            try insert(key: key, at: numberOfKeys)
        }
    }
    
    open func insert(key: T?, at index: Int) throws {
        guard let key = key else {
            return
        }
        
        if numberOfKeys == maxKeys {
            throw NSError(domain: "BTreeNode: BTreeNode is full", code: 0, userInfo: nil)
        }
        
        for keyIndex in stride(from: numberOfKeys - 2, to: index + 1, by: -1) {
            keys.insert(keys[keyIndex], at: keyIndex + 1)
        }
        
        keys[index] = key
        numberOfKeys += 1
    }
    
    open func addChild(child: BTreeNode<T>?, at index: Int) throws {
        guard let child = child else {
            return
        }
        
        if numberOfChilds == maxChilds {
            throw NSError(domain: "BTreeNode: BTreeNode is full", code: 0, userInfo: nil)
        }
        
        for childIndex in stride(from: numberOfChilds - 2, to: index + 1, by: -1) {
            childNodes.insert(childNodes[childIndex], at: childIndex + 1)
        }
        
        childNodes[index] = child
        numberOfChilds += 1
    }
    
    open func replaceChild(child: BTreeNode<T>?, at index: Int) {
        if child != nil, childNodes[index] == nil {
            numberOfChilds += 1
        }
        
        childNodes[index] = child
    }
}

open class BTree<T: Comparable & Hashable> {
    public var root: BTreeNode<T>?
    
    public init(root: BTreeNode<T>) {
        self.root = root
    }
    
    open func traverse() -> Stack<T> {
        var stack = Stack<T>()
        
        guard let root = root else {
            return stack
        }
        
        root.traverse(stack: &stack)
        
        return stack
    }
    
    open func search(key: T) -> Bool {
        guard let root = root else {
            return false
        }
        
        return root.search(key: key)
    }
    
    open func insert(key: T) throws {
        guard var root = root else {
            return
        }
        
        if root.isFull() {
            root = try splitChild(root, of: nil, childIndex: 0)
            self.root = root
        }
        
        var currentNode = root
        
        while !currentNode.isLeafNode() {
            var childIndex = currentNode.numberOfChilds - 1
            for keysIndex in 0 ... currentNode.numberOfKeys {
                if let keysValue = currentNode.keys[keysIndex], keysValue > key {
                    childIndex = keysIndex
                    break
                }
            }
            
            let childNode = currentNode.childNodes[childIndex]!
            if !childNode.isFull() {
                 currentNode = currentNode.childNodes[childIndex]!
            }
            else {
                currentNode = try splitChild(childNode, of: currentNode, childIndex: childIndex)
                
                if key < currentNode.keys[childIndex]! {
                    currentNode = currentNode.childNodes[childIndex]!
                } else {
                    currentNode = currentNode.childNodes[childIndex + 1]!
                }
            }
        }
        
        try currentNode.insert(key: key)
    }
    
    private func splitChild(_ child: BTreeNode<T>, of root: BTreeNode<T>?, childIndex: Int) throws -> BTreeNode<T> {
        let leftChild: BTreeNode<T> = BTreeNode(degree: child.degree)
        let rightChild: BTreeNode<T> = BTreeNode(degree: child.degree)
        
        let parentNodeIndex = child.numberOfKeys / 2
        
        for leftIndex in 0 ..< parentNodeIndex {
            try leftChild.insert(key: child.keys[leftIndex], at: leftIndex)
        }
        
        for leftIndex in 0 ... parentNodeIndex {
            try leftChild.addChild(child: child.childNodes[leftIndex], at: leftIndex)
        }
        
        for rightIndex in parentNodeIndex + 1 ..< child.numberOfKeys {
            try rightChild.insert(key: child.keys[rightIndex], at: rightIndex - parentNodeIndex - 1)
        }
        
        if child.numberOfChilds >= parentNodeIndex + 1 {
            for rightIndex in parentNodeIndex + 1 ... child.numberOfChilds {
                try rightChild.addChild(child: child.childNodes[rightIndex], at: rightIndex - parentNodeIndex - 1)
            }
        }
        
        if let root = root {
            try root.insert(key: child.keys[parentNodeIndex], at: childIndex)
            root.replaceChild(child: leftChild, at: childIndex)
            try root.addChild(child: rightChild, at: childIndex + 1)
            
            return root
        } else {
            let rootNode = BTreeNode<T>(degree: child.degree)
            try rootNode.insert(key: child.keys[parentNodeIndex], at: childIndex)
            try rootNode.addChild(child: leftChild, at: 0)
            try rootNode.addChild(child: rightChild, at: 1)
            
            return rootNode
        }
    }
}
