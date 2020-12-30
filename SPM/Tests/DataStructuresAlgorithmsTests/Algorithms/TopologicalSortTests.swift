//
//  TopologicalSort.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 01.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class TopologicalSortTests: XCTestCase {

    open func testTopologicalSort() throws {
        let graph = setupTestGraph()
        let topological = TopologicalSort(graph: graph)
        
        let sort = try topological.topologicalSort()
        var vertices: [Int] = []
        while !sort.isEmpty() {
            let vertice = try sort.dequeue()
            vertices.append(vertice.id)
        }
        
        //This is one possible topological sort. There can be more than one.
        XCTAssertEqual(vertices, [4, 5, 2, 0, 3, 1])
    }
    
    //https://www.geeksforgeeks.org/topological-sorting/
    private func setupTestGraph() -> DirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2),
                                    Vertice(id: 3), Vertice(id: 4), Vertice(id: 5)]
        let graph = DirectedGraph(vertices: vertices)
        
        graph.addEdge(v1: vertices[2], v2: vertices[3])
        graph.addEdge(v1: vertices[3], v2: vertices[1])
        graph.addEdge(v1: vertices[4], v2: vertices[1])
        graph.addEdge(v1: vertices[4], v2: vertices[0])
        graph.addEdge(v1: vertices[5], v2: vertices[2])
        graph.addEdge(v1: vertices[5], v2: vertices[0])
        
        return graph
    }
}
