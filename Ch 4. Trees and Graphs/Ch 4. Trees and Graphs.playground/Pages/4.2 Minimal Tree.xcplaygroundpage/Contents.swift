import Foundation

/*:
 Given a sorted (increasing order) array with unique integer elements, implement an algorithm
 to create a binary search tree with minimal height.
 */

extension Tree {
    
    init?(sortedElements: [Element]) {
        guard let node = Tree.insert(sortedElements), let element = node.element else { return nil }
        self = .node(element: element, left: node.left, right: node.right)
    }
    
    private static func insert(_ elements: [Element]) -> Tree<Element>? {
        guard !elements.isEmpty else { return nil }
        let mid = elements.count / 2
        let left = insert(Array(elements[0..<mid])) ?? .nil
        let right = insert(Array(elements[mid + 1..<elements.endIndex])) ?? .nil
        return .node(element: elements[mid], left: left, right: right)
    }
}

var treeDepth = 4
var numberOfElements = 2.pow(treeDepth) - 1
var nodeData = (0..<numberOfElements).map { $0 }
var tree = Tree(sortedIncreasing: nodeData)!
print(tree.description)
assert(tree.height == treeDepth - 1, "\(tree.height) == \(treeDepth)")

