//
//  MutableList.swift
//
//  Created by Matthew Carroll on 8/23/16.
//  Copyright © 2016 Matthew Carroll. All rights reserved.
//

import Foundation

public final class MutableList<Element>: ExpressibleByArrayLiteral {
    
    private(set) public var head: Element?
    private(set) public var tail: MutableList?
    private(set) public var count = 0
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    convenience public init(arrayLiteral: Element...) {
        self.init(array: arrayLiteral)
    }
    
    public init(array: [Element]) {
        let list = array.reversed().reduce(MutableList()) { list, x in
            list.insert(element: x)
            return list
        }
        head = list.head
        tail = list.tail
        count = array.count
    }
    
    public init() {
        head = nil
        tail = nil
    }
    
    private init(head: Element, tail: MutableList<Element>?) {
        self.head = head
        self.tail = tail
        count = (tail?.count ?? 0) + 1
    }
    
    public func insert(element: Element) {
        guard let head = head else { return self.head = element }
        tail = MutableList(head: head, tail: tail)
        self.head = element
    }
    
    public func append(list: MutableList) {
        var next: MutableList? = self
        while let _ = next?.tail {
            next = next?.tail
        }
        next?.tail = list
        count += list.count
    }
    
    public func node(at: Int) -> MutableList? {
        guard at > 0 else { return self }
        return tail?.node(at: at - 1)
    }
}

extension MutableList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else { return "nil" }
        let description = "\(head)"
        switch tail {
        case .some(let tail): return description + " -> " + tail.description
        default: return description + " -> " + "nil"
        }
    }
}
