//
//  TravellingSalesman.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class TravelingSalesmanTests: XCTestCase {
    
    open func testTravelingSalesman() {
        let graph = setupTestGraph()
        let travelingSalesman = TravelingSalesman(graph: graph)
        let minRoute = travelingSalesman.travelingSalesman(startCity: graph.vertices[0])
        
        XCTAssertEqual(travelingSalesman.minimumDistance, 80)
        XCTAssertEqual(minRoute, [0, 2, 3, 1, 0])
    }
    
    //https://www.geeksforgeeks.org/traveling-salesman-problem-tsp-implementation
    private func setupTestGraph() -> WeightedUndirectedGraphWithAdjMatrix {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2), Vertice(id: 3)]
        let graph = WeightedUndirectedGraphWithAdjMatrix(vertices: vertices)
        
        graph.addEdge(v1: vertices[0], v2: vertices[1], weight: 10)
        graph.addEdge(v1: vertices[0], v2: vertices[2], weight: 15)
        graph.addEdge(v1: vertices[0], v2: vertices[3], weight: 20)
        graph.addEdge(v1: vertices[1], v2: vertices[2], weight: 35)
        graph.addEdge(v1: vertices[1], v2: vertices[3], weight: 25)
        graph.addEdge(v1: vertices[2], v2: vertices[3], weight: 30)
        
        return graph
    }
}
