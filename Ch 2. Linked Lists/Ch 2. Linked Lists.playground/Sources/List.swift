//
//  List.swift
//
//  Created by Matthew Carroll on 8/15/16.
//  Copyright © 2016 Matthew Carroll. All rights reserved.
//

import Foundation

// The List type from functional languages like Haskell, ML, etc

private enum ListNode<Element>: ExpressibleByArrayLiteral {
    
    case Nil
    indirect case Node(element: Element, next: ListNode)
    
    init(array: [Element]) {
        self = array.reversed().reduce(.Nil) {
            $1 ++ $0
        }
    }
    
    init(arrayLiteral: Element...) {
        self.init(array: arrayLiteral)
    }
    
    func insert(element: Element) -> ListNode {
        return .Node(element: element, next: self)
    }
    
    var head: Element? {
        switch self {
        case .Node(let element, _): return element
        default: return nil
        }
    }
    
    var tail: ListNode {
        switch self {
        case .Node(_, let next): return next
        default: return self
        }
    }
}

infix operator ++

private func ++<Element>(element: Element, list: ListNode<Element>) -> ListNode<Element> {
    return list.insert(element: element)
}

private extension ListNode {
    
    var description: String {
        guard let head = head else { return "nil" }
        let description = "\(head)"
        switch tail {
        case .Node: return description + " -> " + tail.description
        default: return description + " -> " + "nil"
        }
    }
}


public struct List<Element>: ExpressibleByArrayLiteral {
    
    fileprivate let node: ListNode<Element>
    public let startIndex: ListIndex<Element>
    public let endIndex: ListIndex<Element>
    
    public init(arrayLiteral: Element...) {
        self.init(array: arrayLiteral)
    }
    
    public init(array: [Element]) {
        node = ListNode<Element>(array: array)
        startIndex = ListIndex(node: node, position: 0)
        endIndex = ListIndex(node: .Nil, position: array.count)
    }
    
    public init() {
        node = .Nil
        startIndex = ListIndex(node: node, position: 0)
        endIndex = ListIndex(node: node, position: 0)
    }
}


public extension List {
    
    var head: Element? {
        return node.head
    }
    
    var tail: List {
        switch node {
        case .Node(_, let next): return List(node: next, count: count - 1)
        default: return self
        }
    }
    
    func insert(element: Element) -> List {
        let listNode = element ++ node
        return List(node: listNode, count: count + 1)
    }
    
    func append(list: List) -> List {
        guard let head = head else { return list }
        return head ++ tail.append(list: list)
    }
}

public func ++<Element>(element: Element, list: List<Element>) -> List<Element> {
    return list.insert(element: element)
}

public func ++<Element>(lhs: List<Element>, rhs: List<Element>) -> List<Element> {
    return lhs.append(list: rhs)
}


extension List: Collection {
    
    public typealias SubSequence = List
    public typealias IndexDistance = Int
    
    fileprivate init(node: ListNode<Element>, count: IndexDistance) {
        self.node = node
        startIndex = ListIndex(node: node, position: 0)
        endIndex = ListIndex(node: .Nil, position: count)
    }
    
    public func index(after: ListIndex<Element>) -> ListIndex<Element> {
        switch after.node {
        case .Node: return ListIndex(node: after.node.tail, position: after.position + 1)
        default: fatalError("Cannot increment end index")
        }
    }
    
    public subscript(index: ListIndex<Element>) -> Element {
        guard let head = index.node.head else {
            fatalError("Index out of range")
        }
        return head
    }
    
    public subscript(bounds: Range<ListIndex<Element>>) -> List<Element> {
        let count = bounds.upperBound.position - bounds.lowerBound.position
        return List(node: bounds.lowerBound.node, count: count).take(n: count)
    }
    
    public var count: Int {
        return endIndex.position - startIndex.position
    }
}

public extension List where Element: Equatable {
    
    static func ==(lhs: List<Element>, rhs: List<Element>) -> Bool {
        return lhs.elementsEqual(rhs)
    }
}

extension List: CustomStringConvertible {
    
    public var description: String {
        return startIndex.node.description
    }
}


public struct ListIndex<Element> {
    
    fileprivate let node: ListNode<Element>
    fileprivate var position: Int
    
    fileprivate init(node: ListNode<Element>, position: Int) {
        self.node = node
        self.position = position
    }
}

extension ListIndex: Comparable {
    
    public static func ==(lhs: ListIndex<Element>, rhs: ListIndex<Element>) -> Bool {
        return lhs.position == rhs.position
    }
    
    public static func <(lhs: ListIndex<Element>, rhs: ListIndex<Element>) -> Bool {
        return lhs.position < rhs.position
    }
}


public extension List {
    
    func reversed() -> List {
        return foldLeft(List()) { $1 ++ $0 }
    }
    
    func last() -> Element? {
        guard let _ = tail.head else { return head }
        return tail.last()
    }
    
    func foldLeft<T>(_ initial: T, combine: (T, Element) -> T) -> T {
        return reduce(initial, combine)
    }
    
    func reduceLeft<T>(_ combine: (Element, Element) -> T) -> List<T> {
        guard let head = head, let next = tail.head else { return List<T>() }
        let combined = combine(head, next)
        return combined ++ tail.reduceLeft(combine)
    }
    
    func map<T>(_ transform: (Element) -> T) -> List<T> {
        guard let head = head else { return List<T>() }
        let transformed = transform(head)
        return transformed ++ tail.map(transform)
    }
    
    func flatMap<S: Sequence>(_ transform: (Element) -> S) -> List<S.Iterator.Element> {
        typealias E = S.Iterator.Element
        let array: [E] = flatMap(transform)
        return List<E>(array: array)
    }
    
    func filter(_ isIncluded: (Element) -> Bool) -> List {
        guard let head = head else { return self }
        if isIncluded(head) {
            return head ++ tail.filter(isIncluded)
        }
        return tail.filter(isIncluded)
    }
        
    func split(maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true, whereSeparator isSeparator: (Element) -> Bool) -> List<List<Element>> {
        let array: [List<Element>] = split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: isSeparator)
        return List<List<Element>>(array: array)
    }
    
    func split(at: Int) -> (List, List) {
        return (prefix(at), dropFirst(at))
    }
    
    func partition(isLeft: (Element) -> Bool) -> (List, List) {
        guard let head = node.head else { return (self, self) }
        let (left, right) = tail.partition(isLeft: isLeft)
        if isLeft(head) {
            return (head ++ left, right)
        }
        else {
            return (left, head ++ right)
        }
    }
    
    func forAll(predicate: (Element) -> Bool) -> Bool {
        guard let head = head else { return true }
        return predicate(head) && tail.forAll(predicate: predicate)
    }
    
    func scan<T>(initial: T, combine: (T, Element) -> T) -> List<T> {
        guard let head = head else { return List<T>(arrayLiteral: initial) }
        let combined = combine(initial, head)
        return initial ++ tail.scan(initial: combined, combine: combine)
    }
    
    fileprivate func take(n: Int) -> List {
        guard let head = head, n > 0 else { return List() }
        return head ++ tail.take(n: n - 1)
    }
}
