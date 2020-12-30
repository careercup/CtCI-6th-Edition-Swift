//
//  AVLTree.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 05.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class AVLTreeNode<T: Comparable> {
    
    public var left: AVLTreeNode?
    public var right: AVLTreeNode?
    public var parent: AVLTreeNode?
    public var value: T
    public var height: Int
    
    public init(parent: AVLTreeNode?, value: T, height: Int) {
        self.parent = parent
        self.value = value
        self.height = height
    }
    
    open func isRoot() -> Bool {
        return parent == nil
    }
    
    open func other() -> AVLTreeNode? {
        if let left = parent?.left, left.value == value {
            return parent?.right
        }
        
        return parent?.left
    }
}

open class AVLTree<T: Comparable> {
    public var root: AVLTreeNode<T>?
    public var count = 0
    
    public init() { }
    
    open func insert(val: T) {
        count += 1
        
        if root == nil {
            root = AVLTreeNode(parent: nil, value: val, height: 1)
            return
        }
        
        var current = root
        while current != nil, let cur = current {
            if cur.value > val {
                if cur.left == nil {
                    cur.left = AVLTreeNode(parent: cur, value: val, height: 1)
                    increaseHeight(cur)
                    return
                } else {
                    current = cur.left
                }
            } else {
                if cur.right == nil {
                    cur.right = AVLTreeNode(parent: cur, value: val, height: 1)
                    increaseHeight(cur)
                    return
                } else {
                    current = cur.right
                }
            }
        }
    }
    
    @discardableResult
    open func deleteTop() -> AVLTreeNode<T>? {
        guard let value = root?.value else {
            return nil
        }
        
        count -= 1
        
        return delete(value: value, root: &root)
    }
    
    private func delete(value: T, root: inout AVLTreeNode<T>?) -> AVLTreeNode<T>? {
        // step 1: Standard BST deletion
        guard let currentRoot = root else {
            return nil
        }
        
        if value < currentRoot.value {
            // If the key to be deleted is smaller than the root's key, then it lies in left subtree
            currentRoot.left = delete(value: value, root: &currentRoot.left)
        } else if value > currentRoot.value {
            // If the key to be deleted is greater than the root's key, then it lies in right subtree
            currentRoot.right = delete(value: value, root: &currentRoot.right)
        } else {
            // if key is same as root's key, then this is the node to be deleted
            
            // node with only one child or no child
            if currentRoot.left == nil || currentRoot.right == nil {
                root = currentRoot.right == nil ? currentRoot.left : currentRoot.right //could be no or one child
            } else {
                // node with two children: Get the inorder successor (smallest in the right subtree)
                let temp = min(from: currentRoot.right)!
                
                // Copy the inorder successor's data to this node
                currentRoot.value = temp.value
                  
                // Delete the inorder successor
                currentRoot.right = delete(value: temp.value, root: &currentRoot.right)
            }
        }
        
        // If the tree had only one node then return
        if root == nil {
            return nil
        }
        
        // step 2: Update height of the current node
        currentRoot.height = max(currentRoot.left?.height ?? 0, currentRoot.right?.height ?? 0) + 1
          
        // step 3: Get the balance factor of this node (to check whether this node became unbalanced)
        let rootBalance = balance(of: currentRoot)
  
        // If this node becomes unbalanced, then there are 4 cases Left Left Case
        if rootBalance > 1 && balance(of: currentRoot.left) >= 0 {
            return rightRotateForDelete(y: currentRoot)
        }
  
        // Left Right Case
        if rootBalance > 1 && balance(of: currentRoot.left) < 0 {
            currentRoot.left = leftRotateForDelete(x: currentRoot.left)
            return rightRotateForDelete(y: currentRoot)
        }
  
        // Right Right Case
        if (rootBalance < -1 && balance(of: currentRoot.right) <= 0) {
            return leftRotateForDelete(x: currentRoot)
        }
  
        // Right Left Case
        if (rootBalance < -1 && balance(of: currentRoot.right) > 0)
        {
            currentRoot.right = rightRotateForDelete(y: currentRoot.right);
            return leftRotateForDelete(x: currentRoot)
        }
  
        return root
    }
    
    open func minNode() -> AVLTreeNode<T>? {
        return min(from: root)
    }
    
    open func min(from node: AVLTreeNode<T>?) -> AVLTreeNode<T>? {
        var curNode = node
        while curNode?.left != nil {
            curNode = curNode?.left
        }
        
        return curNode
    }
    
    // Get Balance factor of node N
    private func balance(of node: AVLTreeNode<T>?) -> Int {
        guard let left = node?.left, let right = node?.right else {
            return 0
        }
        
        return left.height - right.height
    }
    
    private func increaseHeight(_ node: AVLTreeNode<T>) {
        if node.left != nil, node.right != nil {
            return //must be balanced
        }
        
        var current: AVLTreeNode? = node
        while current != nil, let cur = current {
            let leftHeight = cur.left?.height ?? 0
            let rightHeight = cur.right?.height ?? 0
            
            cur.height = max(leftHeight, rightHeight) + 1
            
            let heightDiff = leftHeight - rightHeight
            
            if heightDiff == 0 {
                return
            } else if heightDiff == -2 {
                let rightLeftHeight = cur.right?.left?.height ?? 0
                let rightRightHeight = cur.right?.right?.height ?? 0
                
                if rightLeftHeight > rightRightHeight {
                    //right left shape -> left + right rotation
                    let nodeToRotate = cur.right?.left
                    rightRotate(n: nodeToRotate)
                    leftRotate(n: nodeToRotate)
                } else {
                    //right right shape -> right rotation
                    leftRotate(n: cur.right)
                }
                current = cur.parent
            } else if heightDiff == 2 {
                let leftLeftHeight = cur.left?.left?.height ?? 0
                let leftRightHeight = cur.left?.right?.height ?? 0
                
                if leftRightHeight > leftLeftHeight {
                    //left right shape -> left + right rotation
                    let nodeToRotate = cur.left?.right
                    leftRotate(n: nodeToRotate)
                    rightRotate(n: nodeToRotate)
                } else {
                    //left left shape -> right rotation
                    rightRotate(n: cur.left)
                }
                current = cur.parent
            } else {
                current = cur.parent
            }
        }
    }
    
    open func description() -> Stack<String> {
        var stack = Stack<String>()
        description(node: root, stack: &stack)
        
        return stack
    }
    
    private func description(node: AVLTreeNode<T>?, stack: inout Stack<String>) {
        if let node = node {
            stack.push(val: "\(node.value): \(node.height)")
            description(node: node.left, stack: &stack)
            description(node: node.right, stack: &stack)
        }
    }
    
    private func rightRotate(n: AVLTreeNode<T>?) {
        let p = n?.parent
        let gp = p?.parent
        let gpLeft = p?.value == gp?.left?.value
        
        p?.left = n?.right
        p?.left?.parent = p
        
        n?.right = p
        p?.parent = n // p? = n?.right
        
        n?.parent = gp
        if gpLeft {
            gp?.left = n
        } else {
            gp?.right = n
        }
        
        if gp == nil {
            root = n
        }
        
        let pLeftHeight = p?.left?.height ?? 0
        let pRightHeight = p?.right?.height ?? 0
        p?.height = max(pLeftHeight, pRightHeight) + 1
        
        let nLeftHeight = n?.left?.height ?? 0
        let nRightHeight = n?.right?.height ?? 0
        n?.height = max(nLeftHeight, nRightHeight) + 1
    }
    
    private func leftRotate(n: AVLTreeNode<T>?) {
        let p = n?.parent
        let gp = p?.parent
        let gpLeft = p?.value == gp?.left?.value
        
        p?.right = n?.left
        p?.right?.parent = p
        
        n?.left = p
        p?.parent = n
        
        n?.parent = gp
        if gpLeft {
            gp?.left = n
        } else {
            gp?.right = n
        }
        
        if gp == nil {
            root = n
        }
        
        let pLeftHeight = p?.left?.height ?? 0
        let pRightHeight = p?.right?.height ?? 0
        p?.height = max(pLeftHeight, pRightHeight) + 1
        
        let nLeftHeight = n?.left?.height ?? 0
        let nRightHeight = n?.right?.height ?? 0
        n?.height = max(nLeftHeight, nRightHeight) + 1
    }
    
    private func rightRotateForDelete(y: AVLTreeNode<T>?) -> AVLTreeNode<T>? {
        let x = y?.left
        let T2 = x?.right
  
        // Perform rotation
        x?.right = y
        y?.left = T2
  
        // Update heights
        y?.height = max(y?.left?.height ?? 0, y?.right?.height ?? 0) + 1
        x?.height = max(x?.left?.height ?? 0, x?.right?.height ?? 0) + 1
  
        // Return new root
        return x
    }
    
    private func leftRotateForDelete(x: AVLTreeNode<T>?) -> AVLTreeNode<T>? {
        let y = x?.left
        let T2 = y?.right
  
        // Perform rotation
        y?.left = x
        x?.right = T2
  
        // Update heights
        x?.height = max(x?.left?.height ?? 0, x?.right?.height ?? 0) + 1
        y?.height = max(y?.left?.height ?? 0, y?.right?.height ?? 0) + 1
  
        // Return new root
        return y
    }
}
