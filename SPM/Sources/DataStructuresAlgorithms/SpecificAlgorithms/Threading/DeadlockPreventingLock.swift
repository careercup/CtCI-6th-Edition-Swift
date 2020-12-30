//
//  DeadlockPreventingLock.swift
//  
//
//  Created by Stefan Jaindl on 07.10.20.
//

import Foundation

open class DeadlockPreventingLock {
    public init(vertices: [Vertice]) {
        graph = DirectedGraph(vertices: vertices)
    }
    
    var graph: DirectedGraph
    
    open func canAddThread(with usage: RessourceUsage) -> Bool {
        buildGraph(with: usage)
        
        if containsCycle() {
            resetGraph(with: usage)
            return false
        }
        
        return true
    }
    
    private func containsCycle() -> Bool {
        var checked = Set<Int>()
        
        for vertice in graph.vertices {
            let visited = Set<Int>()
            if !checked.contains(where: { $0 == vertice.id }) {
                checked.insert(vertice.id)
                
                if containsCycle(vertice: vertice, visited: visited, checked: &checked) {
                    return true
                }
            }
        }
        
        return false
    }
    
    private func containsCycle(vertice: Vertice, visited: Set<Int>, checked: inout Set<Int>) -> Bool {
        var current = graph.neighbours(v: vertice).head
        checked.insert(vertice.id)
        
        var curVisited = visited
        
        while let cur = current {
            if curVisited.contains(where: { $0 == cur.val.id }) {
                return true //already visited this node, cycle detected!
            }
            
            curVisited.insert(cur.val.id)
            if containsCycle(vertice: cur.val, visited: curVisited, checked: &checked) {
                return true
            }
            
            current = cur.next
        }
        
        return false
    }
    
    private func buildGraph(with usage: RessourceUsage) {
        var previous: Vertice? = nil
        for vertice in usage.lockOrder {
            if let previous = previous {
                graph.addEdge(v1: previous, v2: vertice)
            }
            previous = vertice
        }
    }
    
    private func resetGraph(with usage: RessourceUsage) {
        var previous: Vertice? = nil
        for vertice in usage.lockOrder {
            if let previous = previous {
                graph.removeEdge(v1: previous, v2: vertice)
            }
            previous = vertice
        }
    }
}

open class RessourceUsage {
    let lockOrder: [Vertice]
    
    public init(lockOrder: [Vertice]) {
        self.lockOrder = lockOrder
    }
}
