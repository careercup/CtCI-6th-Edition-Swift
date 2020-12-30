import Foundation

open class RedBlackTreeNode<T: Comparable> {
    
    public enum TreeColor {
        case red
        case black
    }
    
    public var left: RedBlackTreeNode?
    public var right: RedBlackTreeNode?
    public var parent: RedBlackTreeNode?
    public var value: T
    public var color = TreeColor.red
    
    public init(parent: RedBlackTreeNode?, value: T) {
        self.parent = parent
        self.value = value
    }
    
    open func isRoot() -> Bool {
        return parent == nil
    }
    
    open func uncle() -> RedBlackTreeNode? {
        if let left = parent?.parent?.left, left.value == parent?.value {
            return parent?.parent?.right
        }
        return parent?.parent?.left
    }
}

extension RedBlackTreeNode : Equatable {
    public static func == (lhs: RedBlackTreeNode, rhs: RedBlackTreeNode) -> Bool {
        return lhs.value == rhs.value
    }
}

open class RedBlackTree<T: Comparable> {
    public var root: RedBlackTreeNode<T>?
    public var count = 0
    
    public init() { }
    
    open func insert(value: T) {
        if root == nil {
            root = RedBlackTreeNode(parent: nil, value: value)
            root?.color = .black
            return
        }
        
        count += 1
        
        let node = bstInsert(value: value)
        
        if node.parent?.color == .black {
            return //everything ok, no double red violation
        }
        
        //else: Double red violation!
        
        if let uncle = node.uncle(), uncle.color == .red {
            //try to recolor: parent and uncle are both red!
            recolor(node: node)
        } else {
            let nIsLeft = node.parent?.left == node
            let pIsLeft = node.parent?.parent?.left == node.parent
            
            if nIsLeft && pIsLeft {
                rightRotate(n: node.parent)
            } else if !nIsLeft && pIsLeft {
                leftRotate(n: node)
                rightRotate(n: node)
            } else if nIsLeft && !pIsLeft {
                leftRotate(n: node)
            } else { //both right
                leftRotate(n: node.parent)
            }
        }
    }
    
    private func bstInsert(value: T) -> RedBlackTreeNode<T> { //assumption: no equal value nodes, root exists
        var curNode = root
        
        while true {
            if curNode!.value > value {
                if curNode?.left != nil {
                    curNode = curNode?.left
                } else {
                    curNode?.left = RedBlackTreeNode(parent: curNode, value: value)
                    curNode = curNode?.left
                    break
                }
            } else {
                if curNode?.right != nil {
                    curNode = curNode?.right
                } else {
                    curNode?.right = RedBlackTreeNode(parent: curNode, value: value)
                    curNode = curNode?.right
                    break
                }
            }
        }
        
        return curNode!
    }
    
    private func recolor(node: RedBlackTreeNode<T>?) {
        guard node != nil else {
            return
        }
        
        let p = node?.parent
        let u = node?.uncle()
        let g = p?.parent
        
        p?.color = .black
        u?.color = .black
        g?.color = .red
        
        if g?.parent == nil {
            g?.color = .black //paint root always black
        }
        
        recolor(node: g)
    }
    
    private func rightRotate(n: RedBlackTreeNode<T>?) {
        let p = n?.parent
        p?.left = n?.right
        p?.left?.parent = p
        
        n?.right = p
        n?.parent = p?.parent
        p?.parent = n
        if n?.parent == nil {
            root = n
        }
        
        p?.color = .red
        n?.color = .black
    }
    
    private func leftRotate(n: RedBlackTreeNode<T>?) {
        let p = n?.parent
        p?.right = n?.left
        p?.right?.parent = p
        
        n?.left = p
        n?.parent = p?.parent
        p?.parent = n
        if n?.parent == nil {
            root = n
        }
        
        n?.color = .black
        p?.color = .red
    }
}
