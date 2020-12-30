//
//  CompressedAVLChildCountTree.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.09.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class CompressedAVLChildCountTreeNode<T: Comparable> {
    public var left: CompressedAVLChildCountTreeNode<T>?
    public var right: CompressedAVLChildCountTreeNode<T>?
    public var parent: CompressedAVLChildCountTreeNode<T>?
    public var value: T
    public var height: Int
    
    //Count of value duplicates in tree node
    public var valueCount: Int
    
    public var numElementsInSubtree: Int
    
    public var totalRank: Int {
        return valueCount - 1 + leftChildRank
    }
    
    public var rightChildRank: Int {
        return right?.numElementsInSubtree ?? 0
    }
    
    public var leftChildRank: Int {
        return left?.numElementsInSubtree ?? 0
    }
    
    public init(parent: CompressedAVLChildCountTreeNode?, value: T, valueCount: Int, numElementsInSubtree: Int, height: Int) {
        self.parent = parent
        self.value = value
        self.valueCount = valueCount
        self.numElementsInSubtree = numElementsInSubtree
        self.height = height
    }
    
    open func isRoot() -> Bool {
        return parent == nil
    }
    
    open func other() -> CompressedAVLChildCountTreeNode? {
        if let left = parent?.left, left.value == value {
            return parent?.right
        }
        
        return parent?.left
    }
}

open class CompressedAVLChildCountTree<T: Comparable> {
    public var root: CompressedAVLChildCountTreeNode<T>?
    
    public init() { }
    
    open func insert(val: T) {
        if root == nil {
            root = CompressedAVLChildCountTreeNode(parent: nil, value: val, valueCount: 1, numElementsInSubtree: 1, height: 1)
            return
        }
        
        var current = root
        while current != nil, let cur = current {
            if cur.value == val {
                cur.valueCount += 1
                cur.numElementsInSubtree += 1
                increaseHeightAndNumElementsInSubtree(cur, duplicate: true)
                break
            } else if cur.value > val {
                if cur.left == nil {
                    cur.left = CompressedAVLChildCountTreeNode(parent: cur, value: val, valueCount: 1, numElementsInSubtree: 1, height: 1)
                    increaseHeightAndNumElementsInSubtree(cur, duplicate: false)
                    return
                } else {
                    current = cur.left
                }
            } else {
                if cur.right == nil {
                    cur.right = CompressedAVLChildCountTreeNode(parent: cur, value: val, valueCount: 1, numElementsInSubtree: 1, height: 1)
                    increaseHeightAndNumElementsInSubtree(cur, duplicate: false)
                    return
                } else {
                    current = cur.right
                }
            }
        }
    }
    
    open func rank(of value: T) -> Int {
        guard root != nil else {
            return 0
        }
        
        if let root = root, root.value == value {
            return root.totalRank
        }
        
        var currentNode = root
        var pathCount = 0
        
        while let curNode = currentNode, curNode.value != value {
            if curNode.value > value {
                //go left
                if curNode.left == nil {
                    break
                } else {
                    currentNode = curNode.left
                }
            } else {
                //go right
                if curNode.right == nil {
                    break
                } else {
                    pathCount += curNode.totalRank + 1
                    currentNode = curNode.right
                }
            }
        }
        
        guard let curNode = currentNode else {
            return 0
        }
        
        if curNode.value == value {
            //exact match
            return pathCount + curNode.totalRank
        } else {
            //element is bigger or smaller
            return pathCount + (curNode.value < value ? curNode.totalRank + 1 : 0)
        }
    }
    
    private func increaseHeightAndNumElementsInSubtree(_ node: CompressedAVLChildCountTreeNode<T>, duplicate: Bool) {
        if node.left != nil, node.right != nil {
            return //must be balanced
        }
        
        var current: CompressedAVLChildCountTreeNode? = node
        while current != nil, let cur = current {
            let leftNumElementsInSubtree = cur.left?.numElementsInSubtree ?? 0
            let rightNumElementsInSubtree = cur.right?.numElementsInSubtree ?? 0
            let leftHeight = cur.left?.height ?? 0
            let rightHeight = cur.right?.height ?? 0
            
            cur.numElementsInSubtree = leftNumElementsInSubtree + rightNumElementsInSubtree + cur.valueCount
            cur.height = max(leftHeight, rightHeight) + 1
            
            let heightDiff = leftHeight - rightHeight
            
            if heightDiff == 0, !duplicate {
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
    
    private func description(node: CompressedAVLChildCountTreeNode<T>?, stack: inout Stack<String>) {
        if let node = node {
            stack.push(val: "\(node.value): \(node.numElementsInSubtree) - (duplicates \(node.valueCount))")
            description(node: node.left, stack: &stack)
            description(node: node.right, stack: &stack)
        }
    }
    
    private func rightRotate(n: CompressedAVLChildCountTreeNode<T>?) {
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
        
        let pLeftNumElementsInSubtree = p?.left?.numElementsInSubtree ?? 0
        let pRightNumElementsInSubtree = p?.right?.numElementsInSubtree ?? 0
        p?.numElementsInSubtree = pLeftNumElementsInSubtree + pRightNumElementsInSubtree + (p?.valueCount ?? 0)
        let pLeftHeight = p?.left?.height ?? 0
        let pRightHeight = p?.right?.height ?? 0
        p?.height = max(pLeftHeight, pRightHeight) + 1
        
        let nLeftNumElementsInSubtree = n?.left?.numElementsInSubtree ?? 0
        let nRightNumElementsInSubtree = n?.right?.numElementsInSubtree ?? 0
        n?.numElementsInSubtree = nLeftNumElementsInSubtree + nRightNumElementsInSubtree + (n?.valueCount ?? 0)
        let nLeftHeight = n?.left?.height ?? 0
        let nRightHeight = n?.right?.height ?? 0
        n?.height = max(nLeftHeight, nRightHeight) + 1
    }
    
    private func leftRotate(n: CompressedAVLChildCountTreeNode<T>?) {
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
        
        let pLeftNumElementsInSubtree = p?.left?.numElementsInSubtree ?? 0
        let pRightNumElementsInSubtree = p?.right?.numElementsInSubtree ?? 0
        p?.numElementsInSubtree = pLeftNumElementsInSubtree + pRightNumElementsInSubtree + (p?.valueCount ?? 0)
        let pLeftHeight = p?.left?.height ?? 0
        let pRightHeight = p?.right?.height ?? 0
        p?.height = max(pLeftHeight, pRightHeight) + 1
        
        let nLeftNumElementsInSubtree = n?.left?.numElementsInSubtree ?? 0
        let nRightNumElementsInSubtree = n?.right?.numElementsInSubtree ?? 0
        n?.numElementsInSubtree = nLeftNumElementsInSubtree + nRightNumElementsInSubtree + (n?.valueCount ?? 0)
        let nLeftHeight = n?.left?.height ?? 0
        let nRightHeight = n?.right?.height ?? 0
        n?.height = max(nLeftHeight, nRightHeight) + 1
    }
}
