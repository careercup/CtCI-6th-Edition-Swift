//
//  Graph.swift
//
//  Created by Matthew Carroll on 7/12/16.
//  Copyright © 2016 Third Cup lc. All rights reserved.
//

import Foundation


public struct Graph<Data: Hashable> {
    
    public let nodes: [GraphNode<Data>]
}

public extension Graph {
    
    init(connectedNodes: [Data: [Data]], unconnectedNodes: [Data]? = nil) {
        var nodeDictionary = [Data: GraphNode<Data>]()
        connectedNodes.forEach { data, adjacentData in
            let node = nodeDictionary[data] ?? GraphNode(data: data, adjacentNodes: nil)
            nodeDictionary[data] = node
            adjacentData.forEach { i in
                let adjacentNode = nodeDictionary[i] ?? GraphNode(data: i, adjacentNodes: nil)
                nodeDictionary[i] = adjacentNode
                node.connectNode(node: adjacentNode)
            }
        }
        var nodes = Array(nodeDictionary.values)
        if let unnconnectedNodes = unconnectedNodes?.map ({ GraphNode(data: $0, adjacentNodes: nil) }) {
            nodes += unnconnectedNodes
        }
        self.nodes = nodes
    }
}

extension GraphNode {
    
    func connectNode(node: GraphNode<Data>) {
        adjacentNodes?.append(node)
        if adjacentNodes == nil {
            adjacentNodes = [node]
        }
    }
}

public extension Graph {
    
    public func markNodesUnvisited() {
        nodes.forEach { node in
            node.visited = false
        }
    }
    
    public func find(_ data: Data) -> GraphNode<Data>? {
        return nodes.first { node in
            node.data == data
        }
    }
}

public final class GraphNode<Data: Hashable> {
    
    public let data: Data
    public var adjacentNodes: [GraphNode<Data>]?
    public var visited = false
    
    public init(data: Data, adjacentNodes: [GraphNode<Data>]?) {
        self.data = data
        self.adjacentNodes = adjacentNodes
    }
}

public extension GraphNode {
    
    public static func ==<Data>(lhs: GraphNode<Data>, rhs: GraphNode<Data>) ->  Bool {
        return lhs === rhs
    }
}

extension GraphNode: Equatable {}

extension GraphNode: Hashable {
    
    public var hashValue: Int { return data.hashValue }
}

extension GraphNode: CustomStringConvertible {
    
    public var description: String {
        var description = "\(data) ->"
        adjacentNodes?.forEach { e in
            description += " \(e.data),"
        }
        return description + " visited \(visited)"
    }
}
