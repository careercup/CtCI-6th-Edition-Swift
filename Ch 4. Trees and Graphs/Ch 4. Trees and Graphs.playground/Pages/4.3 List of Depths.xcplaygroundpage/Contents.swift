import Foundation


/*:
 Give a binary tree, implement an algorithm that creates an array of all nodes 
 at each depth (e.g. if you have a tree with depth D, you will have D arrays)
 */

extension Tree {
    
    func nodesAtEachDepth() -> [[Tree]] {
        return nodesAtDepth(node: self, depth: 0, nodes: [[Tree]]())
    }
    
    private func nodesAtDepth(node: Tree, depth: Int, nodes: [[Tree]]) -> [[Tree]] {
        guard case .node = node else { return nodes }
        
        var nodes = nodes
        if depth == nodes.count {
            nodes.append([node])
        }
        else {
            var nodeList = nodes[depth]
            nodeList.append(node)
            nodes[depth] = nodeList
        }
        nodes = nodesAtDepth(node: node.left, depth: depth + 1, nodes: nodes)
        nodes = nodesAtDepth(node: node.right, depth: depth + 1, nodes: nodes)
        return nodes
    }
}

var treeDepth = 4
var numberOfElements = 2.pow(treeDepth) - 1
var nodeData = (0..<numberOfElements).map { $0 }
var tree = Tree(sortedIncreasing: nodeData)!

let nodesAtDepths = tree.nodesAtEachDepth()
var i = nodesAtDepths.count
for nodes in nodesAtDepths {
    i -= 1
    for node in nodes {
        assert(node.height == i, "\(node.height) \(i)")
        print(node.description)
    }
}

