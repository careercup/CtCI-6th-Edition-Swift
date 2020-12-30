//
//  BellmanFord.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 09.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class BellmanFordTests: XCTestCase {
    
    open func testBellmanFord() {
        let graph = setupTestGraph()
        let bellmanFord = BellmanFord(graph: graph)
        
        XCTAssertEqual(try? bellmanFord.findShortestPath(source: graph.vertices[0], target: graph.vertices[0]), 0)
        XCTAssertEqual(try? bellmanFord.findShortestPath(source: graph.vertices[0], target: graph.vertices[1]), -1)
        XCTAssertEqual(try? bellmanFord.findShortestPath(source: graph.vertices[0], target: graph.vertices[2]), 2)
        XCTAssertEqual(try? bellmanFord.findShortestPath(source: graph.vertices[0], target: graph.vertices[3]), -2)
        XCTAssertEqual(try? bellmanFord.findShortestPath(source: graph.vertices[0], target: graph.vertices[4]), 1)
    }
    
    //https://www.geeksforgeeks.org/bellman-ford-algorithm-dp-23/?ref=lbp
    private func setupTestGraph() -> WeightedDirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2),
                                    Vertice(id: 3), Vertice(id: 4)]
        let graph = WeightedDirectedGraph(vertices: vertices)
        
        graph.addEdge(v1: vertices[0], v2: vertices[1], weight: -1)
        graph.addEdge(v1: vertices[0], v2: vertices[2], weight: 4)
        graph.addEdge(v1: vertices[1], v2: vertices[2], weight: 3)
        graph.addEdge(v1: vertices[1], v2: vertices[3], weight: 2)
        graph.addEdge(v1: vertices[1], v2: vertices[4], weight: 2)
        graph.addEdge(v1: vertices[3], v2: vertices[1], weight: 1)
        graph.addEdge(v1: vertices[3], v2: vertices[2], weight: 5)
        graph.addEdge(v1: vertices[4], v2: vertices[3], weight: -3)
        
        return graph
    }
}
