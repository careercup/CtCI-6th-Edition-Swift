//
//  UnionFind.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 12.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class UnionFindTests: XCTestCase {
    
    open func testUnionFind() {
        let graph = setupTestGraph()
        let unionFind = UnionFind(graph: graph)
        
        XCTAssertEqual(unionFind.numberOfComponents, 4)
        
        unionFind.union(firstIndex: 0, secondIndex: 1)
        XCTAssertEqual(unionFind.find(index: 0), 0)
        XCTAssertEqual(unionFind.find(index: 1), 0)
        XCTAssertEqual(unionFind.numberOfComponents, 3)
    }
    
    //https://www.geeksforgeeks.org/kruskals-minimum-spanning-tree-algorithm-greedy-algo-2/?ref=lbp
    private func setupTestGraph() -> WeightedUndirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2), Vertice(id: 3)]
        let graph = WeightedUndirectedGraph(vertices: vertices)
        
        graph.addEdge(v1: vertices[0], v2: vertices[1], weight: 10)
        graph.addEdge(v1: vertices[0], v2: vertices[2], weight: 6)
        graph.addEdge(v1: vertices[0], v2: vertices[3], weight: 5)
        graph.addEdge(v1: vertices[1], v2: vertices[3], weight: 15)
        graph.addEdge(v1: vertices[2], v2: vertices[3], weight: 4)
        
        return graph
    }
}
