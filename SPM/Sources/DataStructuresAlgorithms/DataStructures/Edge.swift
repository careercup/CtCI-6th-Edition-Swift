//
//  Edge.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 02.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class Edge: Comparable, Hashable {
    public let from: Vertice
    public let to: Vertice
    public let weight: Int
    
    public init(from: Vertice, to: Vertice, weight: Int) {
        self.from = from
        self.to = to
        self.weight = weight
    }
    
    public static func < (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.weight < rhs.weight
    }
    
    public static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(from)
        hasher.combine(to)
        hasher.combine(weight)
    }
}
