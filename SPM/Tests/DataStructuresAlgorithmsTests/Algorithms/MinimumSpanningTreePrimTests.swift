//
//  MinimumSpanningTreePrim.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 13.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MinimumSpanningTreePrimTests: XCTestCase {
    
    open func testMSTPrim() {
        let graph = setupTestGraph()
        let mstPrim = MinimumSpanningTreePrim(graph: graph)
        let mst = mstPrim.minimumSpanningTree()
        
        let tree = mst.compactMap {
            return "\($0.from.id) -> \($0.to.id): \($0.weight)"
        }
        
        XCTAssertEqual(tree, ["0 -> 1: 4",
                              "0 -> 7: 8",
                              "7 -> 6: 1",
                              "6 -> 5: 2",
                              "5 -> 2: 4",
                              "2 -> 8: 2",
                              "2 -> 3: 7",
                              "3 -> 4: 9"])
    }
    
    private func setupTestGraph() -> WeightedUndirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2), Vertice(id: 3),
                                   Vertice(id: 4), Vertice(id: 5), Vertice(id: 6), Vertice(id: 7), Vertice(id: 8)]
        let graph = WeightedUndirectedGraph(vertices: vertices)
        
        //https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/?ref=lbp
        graph.addEdge(v1: vertices[0], v2: vertices[1], weight: 4)
        graph.addEdge(v1: vertices[0], v2: vertices[7], weight: 8)
        graph.addEdge(v1: vertices[1], v2: vertices[2], weight: 9) //changed to 9, as example algo doesn't pick this edge
        graph.addEdge(v1: vertices[1], v2: vertices[7], weight: 11)
        graph.addEdge(v1: vertices[2], v2: vertices[3], weight: 7)
        graph.addEdge(v1: vertices[2], v2: vertices[5], weight: 4)
        graph.addEdge(v1: vertices[2], v2: vertices[8], weight: 2)
        graph.addEdge(v1: vertices[3], v2: vertices[4], weight: 9)
        graph.addEdge(v1: vertices[3], v2: vertices[5], weight: 14)
        graph.addEdge(v1: vertices[4], v2: vertices[5], weight: 10)
        graph.addEdge(v1: vertices[5], v2: vertices[6], weight: 2)
        graph.addEdge(v1: vertices[6], v2: vertices[7], weight: 1)
        graph.addEdge(v1: vertices[6], v2: vertices[8], weight: 6)
        graph.addEdge(v1: vertices[7], v2: vertices[8], weight: 7)
        
        return graph
    }
}
