import Foundation

/*:
 Given a directed graphs, implement an algorithm to find if there is a path 
 between two nodes.
 */

/*:
 4.1 DFS solution
 */

extension Graph {
    
    func hasRouteDFS(from: Data, to: Data) -> Bool {
        markNodesUnvisited()
        guard let fromNode = find(from) else { return false }
        return fromNode.dfsSearch(to)
    }
}

extension GraphNode {
    
    fileprivate func dfsSearch(_ data: Data) -> Bool {
        visited = true
        guard self.data != data else { return true }
        guard let adjacentNodes = adjacentNodes else { return false }
        for node in adjacentNodes where node.visited == false {
            guard !node.dfsSearch(data) else { return true }
        }
        return false
    }
}

let connectedNodes = [0: [1,4,5], 1: [3,4], 2: [1], 3: [2,4]]

var graph = Graph(connectedNodes: connectedNodes)

connectedNodes.forEach { from, to in
    to.forEach { toNode in
        assert(graph.hasRouteDFS(from: from, to: toNode) == true)
    }
}
assert(graph.hasRouteDFS(from: 0, to: 2) == true)
assert(graph.hasRouteDFS(from: 3, to: 0) == false)
assert(graph.hasRouteDFS(from: 2, to: 3) == true)


/*:
 4.1 BFS Solution
 */

extension Graph {
    
    func hasRouteBFS(from: Data, to: Data) -> Bool {
        markNodesUnvisited()
        guard let fromNode = find(from) else { return false }
        var queue = ArraySlice([fromNode])
        while let node = queue.first {
            node.visited = true
            guard node.data != to else { return true }
            queue = queue.dropFirst()
            guard let adjacentNodes = node.adjacentNodes else { continue }
            for adjacentNode in adjacentNodes where adjacentNode.visited == false {
                queue.append(adjacentNode)
            }
        }
        return false
    }
}

connectedNodes.forEach { from, to in
    to.forEach { toNode in
        assert(graph.hasRouteBFS(from: from, to: toNode) == true)
    }
}

assert(graph.hasRouteBFS(from: 0, to: 2) == true)
assert(graph.hasRouteBFS(from: 3, to: 0) == false)
assert(graph.hasRouteBFS(from: 2, to: 3) == true)
