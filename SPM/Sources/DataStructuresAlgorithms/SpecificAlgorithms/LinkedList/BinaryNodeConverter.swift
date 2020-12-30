//
//  BinaryNodeConverter.swift
//  
//
//  Created by Stefan Jaindl on 09.12.20.
//

import Foundation

open class BinaryNodeConverter<T: Equatable> {
    public init() { }
    
    //Converts a BST into a doubly linked list in O(N) time and O(1) space
    open func convertBinarySearchTreeToDoubleLinkedList(root: BiNode<T>?) -> BiNodes<T>? {
        guard let root = root else {
            return nil
        }
        
        let leftNodes = convertBinarySearchTreeToDoubleLinkedList(root: root.left)
        let rightNodes = convertBinarySearchTreeToDoubleLinkedList(root: root.right)
        
        let lastOnLeft = leftNodes?.right
        let firstRight = rightNodes?.left
        
        lastOnLeft?.right = root
        root.left = lastOnLeft
        
        root.right = firstRight
        firstRight?.left = root
        
        return BiNodes(left: leftNodes?.left ?? root, right: rightNodes?.right ?? root)
    }
}

open class BiNode<T: Equatable>: Equatable {
    var left: BiNode?
    var right: BiNode?
    var data: T
    
    init(data: T, left: BiNode? = nil, right: BiNode? = nil) {
        self.left = left
        self.right = right
        self.data = data
    }
    
    public static func == (lhs: BiNode<T>, rhs: BiNode<T>) -> Bool {
        return lhs.data == rhs.data && lhs.left == rhs.left && lhs.right == rhs.right
    }
}

public struct BiNodes<T: Equatable> {
    let left: BiNode<T>?
    let right: BiNode<T>?
}
