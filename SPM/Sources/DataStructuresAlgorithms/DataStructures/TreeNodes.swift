//
//  SimpleTreeNode.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 23.06.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class SimpleTreeNode<T: Comparable> {
    
    public var left: SimpleTreeNode<T>?
    public var right: SimpleTreeNode<T>?
    public var value: T
    public var numElements = 0
    
    public init(value: T) {
        self.value = value
    }
    
    public init(value: T, numElements: Int) {
        self.value = value
        self.numElements = numElements
    }
    
    public func isLeaveNode() -> Bool {
        return left == nil && right == nil
    }
}

open class TreeNode<T: Comparable>: Equatable {
    
    public var left: TreeNode<T>?
    public var right: TreeNode<T>?
    public var parent: TreeNode<T>?
    public var value: T
    
    public init(value: T) {
        self.value = value
    }
    
    public init(value: T, parent: TreeNode<T>?) {
        self.value = value
        self.parent = parent
    }
    
    public static func == (lhs: TreeNode<T>, rhs: TreeNode<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    public func isLeaveNode() -> Bool {
        return left == nil && right == nil
    }
}
