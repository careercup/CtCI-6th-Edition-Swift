//
//  TreeClass.swift
//
//  Created by Matthew Carroll on 7/9/16.
//  Copyright © 2016 Third Cup lc. All rights reserved.
//

import Foundation


public final class TreeClass<Element: Comparable> {
    
    public let element: Element
    public fileprivate(set) var left: TreeClass<Element>?
    public fileprivate(set) var right: TreeClass<Element>?
    public fileprivate(set) weak var parent: TreeClass<Element>?
    public fileprivate(set) var height = 0
    
    public init(element: Element, left: TreeClass<Element>?, right: TreeClass<Element>?) {
        self.element = element
        self.left = left
        self.right = right
        left?.parent = self
        right?.parent = self
        height = max(left?.height ?? 0, right?.height ?? 0) + 1
    }
}

public extension TreeClass {
    
    public convenience init?(sortedIncreasing: [Element]) {
        guard let node = TreeClass.insert(sortedIncreasing) else { return nil }
        self.init(element: node.element, left: node.left, right: node.right)
    }
    
    private static func insert(_ elements: [Element]) -> TreeClass<Element>? {
        guard !elements.isEmpty else { return nil }
        let mid = elements.count / 2
        let left = insert(Array(elements[0..<mid]))
        let right = insert(Array(elements[mid + 1..<elements.endIndex]))
        return TreeClass(element: elements[mid], left: left, right: right)
    }
}

public extension TreeClass {
    
    public convenience init(element: Element, leftElement: Element?, rightElement: Element?) {
        var left: TreeClass<Element>?
        if let leftElement = leftElement {
            left = TreeClass(element: leftElement, left: nil, right: nil)
        }
        var right: TreeClass<Element>?
        if let rightElement = rightElement {
            right = TreeClass(element: rightElement, left: nil, right: nil)
        }
        self.init(element: element, left: left, right: right)
    }
}

public extension TreeClass {
    
    public func insert(_ x: Element) -> Int {
        if x <= element {
            if let left = left {
                height = left.insert(x) + 1
                return height
            }
            left = TreeClass(element: x, left: nil, right: nil)
        }
        else {
            if let right = right {
                height = right.insert(x) + 1
                return height
            }
            right = TreeClass(element: x, left: nil, right: nil)
        }
        if left == nil || right == nil {
            height += 1
        }
        left?.parent = self
        right?.parent = self
        return height
    }
    
    func find(_ x: Element) -> TreeClass<Element>? {
        if x == element {
            return self
        }
        if x < element {
            return left?.find(x)
        }
        return right?.find(x)
    }

    var isLeafNode: Bool {
        return left == nil && right == nil
    }
    
    var isLeftChild: Bool {
        return parent?.left === self
    }
}

extension TreeClass: CustomStringConvertible {
    
    public var description: String {
        let le = left?.element == nil ? "nil" : "\(left!.element)"
        let re = right?.element == nil ? "nil" : "\(right!.element)"
        let me = "\(element), {\(le), \(re)}  height: \(height)"
        let l = left == nil ? "" : "\n -> " + left!.description
        let r = right == nil ? "" : "\n -> " + right!.description
        return me + l + r
    }
}

