import Foundation

public enum MyError: Error {
    case runtimeError(String)
}

open class Node<T: Hashable>: Hashable {
    var next: Node?
    var val: T
    var prev: Node?
    
    init(val: T, next: Node? = nil, prev: Node? = nil) {
        self.val = val
        self.next = next
        self.prev = prev
    }
    
    public static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.val == rhs.val && lhs.next == rhs.next && lhs.prev == rhs.prev
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(val)
        hasher.combine(next)
        hasher.combine(prev)
    }
}

open class DoubleLinkedList<T: Hashable> {
    public var head: Node<T>?
    public var tail: Node<T>?
    public var count: Int = 0
    
    public init() { }
    
    open func add(node: Node<T>) {
        if count == 0 {
            head = node
            tail = node
        } else {
            let temp = tail
            tail = node
            temp?.next = tail
            tail?.prev = temp
        }
        count += 1
    }
    
    open func removeFirst() throws -> Node<T>? {
        if count == 0 {
            throw MyError.runtimeError("Invalid call")
        }
        
        let node = head
        
        if count == 1 {
            head = nil; tail = nil
        } else {
            head = node?.next
            head?.prev = nil
            node?.next = nil
        }
        
        count -= 1
        
        return node
    }
    
    open func removeLast() throws -> Node<T>? {
        if count == 0 {
            throw MyError.runtimeError("Invalid call")
        }
        
        let node = tail
        
        if count == 1 {
            head = nil; tail = nil
        } else {
            tail?.prev?.next = nil
            tail = tail?.prev
        }
        
        count -= 1
        
        return node
    }
    
    open func removeByKey(val: Int) {
        var current = head
        
        while current != nil {
            if let cur = current, let curVal = current?.val as? Int, curVal == val, let headVal = head?.val as? Int, let tailVal = tail?.val as? Int {
                if count == 1 {
                    head = nil; tail = nil;
                } else if curVal == headVal {
                    head?.next?.prev = nil
                    head = head?.next
                } else if curVal == tailVal {
                    tail?.prev?.next = nil
                    tail = tail?.prev
                } else {
                    if let prev = cur.prev {
                        prev.next = cur.next
                    }
                    if let next = cur.next {
                        next.prev = cur.prev
                    }
                }
                
                if headVal == tailVal {
                    head = tail
                }
                
                count -= 1
                
                return
            }
            
            current = current?.next
        }
    }
}
