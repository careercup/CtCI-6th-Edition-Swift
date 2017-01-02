import Foundation

/*:
 Implement a function to check if a binary tree is a binary search tree.
 */

extension Tree {
    
    func isBST() -> Bool {
        return isBST(min: nil, max: nil)
    }
    
    private func isBST(min: Element?, max: Element?) -> Bool {
        guard case .node = self else { return true }
        
        if let min = min, let element = element, min >= element {
            return false
        }
        if let max = max, let element = element, max < element {
            return false
        }
        let leftIsBST = left.isBST(min: min, max: element)
        if leftIsBST {
            return right.isBST(min: element, max: max)
        }
        return false
    }
}

let three = Tree.node(element: 3, left: .nil, right: .nil)
let seven = Tree.node(element: 7, left: .nil, right: .nil)
let eleven = Tree.node(element: 11, left: .nil, right: .nil)

var tree = Tree.node(element: 7, left: three, right: .nil)
assert(tree.isBST())

tree = .node(element: 7, left: .nil, right: three)
assert(tree.isBST() == false)

tree = .node(element: 7, left: three, right: eleven)
assert(tree.isBST())

tree = .node(element: 7, left: eleven, right: three)
assert(tree.isBST() == false)

tree = .node(element: 7, left: eleven, right: eleven)
assert(tree.isBST() == false)

tree = .node(element: 7, left: three, right: three)
assert(tree.isBST() == false)


var treeDepth = 4
var numberOfElements = 2.pow(treeDepth) - 1
var nodeData = (0..<numberOfElements).map { $0 }
tree = Tree(sortedIncreasing: nodeData)!
assert(tree.isBST())


var left = tree.left
var right = tree.right

var lessThanNode = Tree.node(element: -1, left: left, right: left.right)
tree = .node(element: 7, left: lessThanNode, right: tree.right)
assert(tree.isBST() == false)

lessThanNode = .node(element: 8, left: right.left, right: right)
tree = .node(element: 7, left: left, right: lessThanNode)
assert(tree.isBST() == false)

tree = .node(element: 7, left: .nil, right: .nil)
tree = tree.insert(3)
tree = tree.insert(1)
let leftLeft = tree.left.insert(8)
tree = .node(element: 7, left: leftLeft, right: .nil)
assert(tree.isBST() == false)

lessThanNode = .node(element: 1, left: three, right: .nil)
tree = .node(element: 7, left: lessThanNode, right: .nil)
assert(tree.isBST() == false)
print("\(tree.description)")



