//
//  MinimumSpanningTreeKruskal.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 12.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MinimumSpanningTreeKruskalTests: XCTestCase {
    
    open func testMSTKruskalQuickSort() {
        let graph = setupTestGraph()
        let mstKruskal = MinimumSpanningTreeKruskal(graph: graph)
        let mst = mstKruskal.minimumSpanningTreeQuickSort()
        
        let array: [String] = mst.compactMap {
            return "\($0.from.id) -> \($0.to.id): \($0.weight)"
        }
        
        XCTAssertEqual(array, ["6 -> 7: 1",
                               "2 -> 8: 2",
                               "6 -> 5: 2",
                               "1 -> 0: 4",
                               "2 -> 5: 4",
                               "3 -> 2: 7",
                               "0 -> 7: 8",
                               "3 -> 4: 9"])
    }
    
    open func testMSTKruskalHeap() {
        let graph = setupTestGraph()
        let mstKruskal = MinimumSpanningTreeKruskal(graph: graph)
        let mst = mstKruskal.minimumSpanningTreeQuickSort()
        
        let array: [String] = mst.compactMap {
            return "\($0.from.id) -> \($0.to.id): \($0.weight)"
        }
        
        XCTAssertEqual(array, ["6 -> 7: 1",
                               "2 -> 8: 2",
                               "6 -> 5: 2",
                               "1 -> 0: 4",
                               "2 -> 5: 4",
                               "3 -> 2: 7",
                               "0 -> 7: 8",
                               "3 -> 4: 9"])
    }
    
    //https://www.geeksforgeeks.org/kruskals-minimum-spanning-tree-algorithm-greedy-algo-2/?ref=lbp
    private func setupTestGraph() -> WeightedUndirectedGraph {
        let vertices: [Vertice] =
            [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2), Vertice(id: 3), Vertice(id: 4),
             Vertice(id: 5), Vertice(id: 6), Vertice(id: 7), Vertice(id: 8)]
        let graph = WeightedUndirectedGraph(vertices: vertices)
        
        graph.addEdge(v1: vertices[0], v2: vertices[1], weight: 4)
        graph.addEdge(v1: vertices[0], v2: vertices[7], weight: 8)
        graph.addEdge(v1: vertices[1], v2: vertices[2], weight: 8)
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
