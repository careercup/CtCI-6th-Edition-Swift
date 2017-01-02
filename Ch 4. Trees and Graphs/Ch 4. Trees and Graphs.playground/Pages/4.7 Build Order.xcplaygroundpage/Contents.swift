import Foundation

/*:
 You are given a list of projects and dependencies (which is a list of pairs of projects
 where the first project is dependent on the second project). All of a project's dependencies
 must be built before the project is. Find a build order that allows the project to be built. 
 If there is no valid build order, return an error.
 
 Example:
 
 Input:
 
 `projects: a, b, c, d, e, f` 
 
 `dependencies: (d, a), (b, f), (d, b), (a, f), (c, d)`
 
 `possible output: f, e, a, b, d, c`
 */

extension Graph where Data: Hashable {
    
    init(projects: [Data], projectDependencies: [(project: Data, dependency: Data)]) {
        var connectedNodes = [Data: [Data]]()
        for dep in projectDependencies {
            var dependencies = connectedNodes[dep.project] ?? [Data]()
            dependencies.append(dep.dependency)
            connectedNodes[dep.project] = dependencies
        }
        let unconnectedNoes = Array(Set(projects).subtracting(connectedNodes.keys))
        self.init(connectedNodes: connectedNodes, unconnectedNodes: unconnectedNoes)
    }
    
    func buildOrder(projects: [Data]) -> [Data]? {
        var buildOrder = [Data]()
        var builtProjects = Set<Data>()
        for project in projects {
            guard !builtProjects.contains(project) else { continue }
            guard let node = find(project) else { return nil }
            
            markNodesUnvisited()
            guard let path = node.dfsPathAcyclic?.reversed().map ({ $0.data }) else { return nil }
            for project in path where !builtProjects.contains(project) {
                buildOrder.append(project)
            }
            builtProjects.formUnion(path)
        }
        return buildOrder
    }
}

extension GraphNode {
    
    var dfsPath: [GraphNode] {
        var dfsPath = [GraphNode]()
        visited = true
        dfsPath.append(self)
        guard let adjacentNodes = adjacentNodes else { return dfsPath }
        for node in adjacentNodes where node.visited == false {
            dfsPath += node.dfsPath
        }
        return dfsPath
    }
    
    var dfsPathAcyclic: [GraphNode]? {
        return dfsPathAcyclic(visitedNodes: Set())
    }
    
    private func dfsPathAcyclic(visitedNodes: Set<GraphNode<Data>>) -> [GraphNode]? {
        guard !visitedNodes.contains(self) else { return nil }
        var dfsPath = [self]
        guard let adjacentNodes = adjacentNodes else { return dfsPath }
        
        var visitedNodes = visitedNodes
        visitedNodes.insert(self)
        for node in adjacentNodes {
            guard let path = node.dfsPathAcyclic(visitedNodes: visitedNodes) else { return nil }
            dfsPath += path
        }
        return dfsPath
    }
    
    var containsCycleDFS: Bool {
        return containsCycleDFS(visitedNodes: Set())
    }
    
    private func containsCycleDFS(visitedNodes: Set<GraphNode<Data>>) -> Bool {
        guard !visitedNodes.contains(self) else { return true }
        guard let adjacentNodes = adjacentNodes else { return false }
        var visitedNodes = visitedNodes
        visitedNodes.insert(self)
        for node in adjacentNodes {
            guard !node.containsCycleDFS(visitedNodes: visitedNodes) else { return true }
        }
        return false
    }
}


var projects = ["a", "b", "c", "d", "e", "f"]
var dependencies: [(project: String, dependency: String)] = [("d", "a"), ("b", "f"), ("d", "b"), ("a", "f"), ("c", "d")]
var projectGraph = Graph(projects: projects, projectDependencies: dependencies)
var buildOrder = projectGraph.buildOrder(projects: projects)
assert(buildOrder! == ["f", "a", "b", "d", "c", "e"])


projects = ["a", "b"]
dependencies = [("b", "a"), ("a", "b")]
projectGraph = Graph(projects: projects, projectDependencies: dependencies)
buildOrder = projectGraph.buildOrder(projects: projects)
assert(buildOrder == nil)
