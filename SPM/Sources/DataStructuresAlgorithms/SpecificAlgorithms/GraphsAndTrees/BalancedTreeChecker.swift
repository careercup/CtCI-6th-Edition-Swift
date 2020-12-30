//
//  BalancedTreeChecker.swift
//  
//
//  Created by Stefan Jaindl on 25.06.20.
//

import Foundation

open class BalancedTreeChecker<T: Comparable> {
    
    public init() { }
    
    //Given: Checks whether a Binary Tree is balanced (= height of left and right child of any node doesn't differ more than one)
    open func isBalanced(root: SimpleTreeNode<T>) -> Bool {
        return isBalancedRecursive(root: root).valid
    }
    
    private func isBalancedRecursive(root: SimpleTreeNode<T>?) -> ResultWrapper {
        guard let root = root else {
            return ResultWrapper(height: 0, valid: true)
        }
        
        var leftResult = isBalancedRecursive(root: root.left)
        //If balance check for left or right child already failed, just pass invalid result up
        if !leftResult.valid {
            return leftResult
        }
        
        let rightResult = isBalancedRecursive(root: root.right)
        if !rightResult.valid {
            return rightResult
        }
        
        if abs(leftResult.height - rightResult.height) > 1 {
            //height differs more than one = not balanced!
            //Return any result as invalid
            leftResult.valid = false
            return leftResult
        }
        
        var maxHeightResult = max(leftResult, rightResult)
        maxHeightResult.height += 1
        
        return maxHeightResult
    }
}

private struct ResultWrapper: Comparable {
    var height: Int
    var valid: Bool
    
    static func < (lhs: ResultWrapper, rhs: ResultWrapper) -> Bool {
        return lhs.height < rhs.height
    }
}
