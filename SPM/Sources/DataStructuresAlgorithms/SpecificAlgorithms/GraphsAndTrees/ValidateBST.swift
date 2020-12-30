//
//  ValidateBST.swift
//  
//
//  Created by Stefan Jaindl on 28.06.20.
//

import Foundation

open class BSTValidator<T: Comparable> {
    
    public init() { }
    
    //Given: Binary tree. Output: Bool indicating whether BT is a BST.
    //BST defintion: for each node - max value left subtree <= root node < min value right subtree
    open func isValidBST(root: SimpleTreeNode<T>) -> Bool {
        return isValidBST(root: root).valid
    }
    
    private func isValidBST(root: SimpleTreeNode<T>) -> ResultWrapper<T> {
        var leftResult: ResultWrapper<T>
        var rightResult: ResultWrapper<T>
        
        if let left = root.left {
            leftResult = isValidBST(root: left)
        } else {
            leftResult = ResultWrapper(min: root.value, max: root.value, valid: true)
        }
        
        //If BST check for left child already failed, just pass invalid result up
        if !leftResult.valid {
            return leftResult
        }
        
        if let right = root.right {
            rightResult = isValidBST(root: right)
        } else {
            rightResult = ResultWrapper(min: root.value, max: root.value, valid: true)
        }
        
        //If BST check for right child already failed, just pass invalid result up
        if !rightResult.valid {
            return rightResult
        }
        
        if !root.isLeaveNode() && !(root.value >= leftResult.max && root.value < rightResult.min) {
            leftResult.valid = false
            return leftResult
        }
        
        leftResult.max = rightResult.max
        
        return leftResult
    }
}

private struct ResultWrapper<T: Comparable> {
    var min: T
    var max: T
    var valid: Bool
}
