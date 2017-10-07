//
//  Tree.swift
//
//  Created by Matthew Carroll on 9/16/16.
//  Copyright © 2016 Third Cup lc. All rights reserved.
//

import Foundation


public enum Tree<Element: Comparable> {
    
    case `nil`
    indirect case node(element: Element, left: Tree, right: Tree)
}

public extension Tree {
    
    public init?(sortedIncreasing: [Element]) {
        guard let node = Tree.insert(sortedIncreasing), let element = node.element else { return nil }
        self = .node(element: element, left: node.left, right: node.right)
    }
    
    private static func insert(_ elements: [Element]) -> Tree<Element>? {
        guard !elements.isEmpty else { return nil }
        let mid = elements.count / 2
        let left = insert(Array(elements[0..<mid])) ?? .nil
        let right = insert(Array(elements[mid + 1..<elements.endIndex])) ?? .nil
        return .node(element: elements[mid], left: left, right: right)
    }
}

public extension Tree {
    
    public var element: Element? {
        switch self {
        case .nil: return nil
        case .node(let element, _, _): return element
        }
    }
    
    public var left: Tree {
        switch self {
        case .nil: return .nil
        case .node(_, let leftChild, _): return leftChild
        }
    }
    
    public var right: Tree {
        switch self {
        case .nil: return .nil
        case .node(_, _, let rightChild): return rightChild
        }
    }
}

public extension Tree {
    
    public func insert(_ x: Element) -> Tree {
        switch self {
        case .nil: return .node(element: x, left: .nil, right: .nil)
        case .node(let element, let left, let right):
            let (left, right) = x <= element ? (left.insert(x), right) : (left, right.insert(x))
            return .node(element: element, left: left, right: right)
        }
    }
    
    public func find(_ x: Element) -> Tree? {
        switch self {
        case .nil: return nil
        case .node(let element, let left, let right):
            guard element != x else { return self }
            return x < element ? left.find(x) : right.find(x)
        }
    }
    
    public var height: Int {
        switch self {
        case .nil: return 0
        case .node: return depth(height: -1)
        }
    }
    
    private func depth(height: Int) -> Int {
        switch self {
        case .nil: return height
        case .node: return max(left.depth(height: height + 1), right.depth(height: height + 1))
        }
    }
}

public extension Tree {
    
    public var description: String {
        switch self {
        case .nil: return "nil"
        case .node(let element, _, _):
            let le = left.element == nil ? "nil" : "\(left.element!)"
            let re = right.element == nil ? "nil" : "\(right.element!)"
            let me = "\(element), {\(le), \(re)}  height: \(height)"
            let l = left.isNil ? "" : "\n -> " + left.description
            let r = right.isNil ? "" : "\n -> " + right.description
            return me + l + r
        }
    }
    
    var isNil: Bool {
        if case .nil = self {
            return true
        }
        return false
    }
}
