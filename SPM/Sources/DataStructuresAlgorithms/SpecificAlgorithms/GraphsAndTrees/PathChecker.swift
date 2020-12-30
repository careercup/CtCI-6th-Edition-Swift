//
//  PathChecker.swift
//  
//
//  Created by Stefan Jaindl on 22.06.20.
//

import Foundation

extension DirectedGraph {
    
    open func pathExists(from: Vertice, to: Vertice) -> Bool {
        let queue = Queue<Vertice>()
        
        queue.enqueue(val: from)
        while !queue.isEmpty(), let vertice = try? queue.dequeue() {
            vertice.visited = true
            if vertice == to {
                return true
            }
            
            var currentNode = neighbours(v: vertice).head
            while let neighbour = currentNode {
                if !neighbour.val.visited {
                    queue.enqueue(val: neighbour.val)
                }
                currentNode = neighbour.next
            }
        }
        
        return false
    }
}
