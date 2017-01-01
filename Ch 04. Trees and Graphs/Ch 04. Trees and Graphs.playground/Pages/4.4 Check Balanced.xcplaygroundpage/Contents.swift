import Foundation

/*:
 Implement a function to check if a binary tree is balanced. For this question
 a binary tree is defined as a tree whose subtrees' heights differ by no more than 1.
 */

extension Tree {
    
    func isBalanced() -> Bool {
        guard !isNil else { return true }
        guard hasOneChild else {
            return left.isBalanced() ? right.isBalanced() : false
        }
        let childAlsoHasAChild = left.hasChild || right.hasChild
        return childAlsoHasAChild ? false : true
    }
    
    private var hasOneChild: Bool {
        return left.isNil && !right.isNil || !left.isNil && right.isNil
    }
    
    private var hasChild: Bool {
        return !left.isNil || !right.isNil
    }
}

var tree = Tree.node(element: 7, left: .nil, right: .nil)
assert(tree.isBalanced())
tree = tree.insert(3)
assert(tree.isBalanced())
tree = tree.insert(11)
assert(tree.isBalanced())
tree = tree.insert(13)
print(tree.description)
assert(tree.isBalanced())
tree = tree.insert(14)
assert(tree.isBalanced() == false)
tree = tree.insert(1)
assert(tree.isBalanced() == false)
tree = tree.insert(9)
assert(tree.isBalanced())
tree = tree.insert(0)
assert(tree.isBalanced() == false)
tree = tree.insert(5)
assert(tree.isBalanced())
