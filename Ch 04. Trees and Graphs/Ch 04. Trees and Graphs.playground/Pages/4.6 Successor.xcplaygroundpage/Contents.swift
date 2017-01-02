import Foundation

/*:
 Implement an algorithm to find the next node (i.e in-order successor) of a given 
 node in a binary search tree. You may assume that each node has a link to its parent.
 */

extension TreeClass {
    
    var successor: TreeClass<Element>? {
        var minParent: TreeClass? = self
        while let _minParent = minParent, !_minParent.isLeftChild {
            minParent = minParent?.parent
        }
        minParent = minParent?.parent
        
        var minRightNode = right
        while let _ = minRightNode?.left {
            minRightNode = minRightNode?.left
        }
        if let minParent = minParent, let minRightNode = minRightNode {
            return minParent.element < minRightNode.element ? minParent : minRightNode
        }
        return minParent == nil ? minRightNode : minParent
    }    
}

var treeHeight = 4
var numberOfElements = Int(pow(2, Double(treeHeight)) - 1)
var nodeData = (0..<numberOfElements).map { $0 }
var rootNode = TreeClass(sortedIncreasing: nodeData)!

nodeData.dropLast().forEach { e in
    assert(rootNode.find(e)?.successor?.element == e + 1)
}

assert(rootNode.find(nodeData.last!)?.successor?.element == nil)

rootNode = TreeClass(element: 7, left: nil, right: nil)
rootNode.insert(4)
rootNode.insert(1)
assert(rootNode.find(4)?.successor?.element == 7)
