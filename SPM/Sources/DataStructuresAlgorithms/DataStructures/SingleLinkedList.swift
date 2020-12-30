import Foundation

open class SingleNode<T: Comparable> {
    var next: SingleNode?
    var val: T
    
    init(val: T, next: SingleNode? = nil) {
        self.val = val
        self.next = next
    }
}

open class SingleLinkedList<T: Comparable> {
    public var head: SingleNode<T>?
    public var count: Int = 0
    
    public init() { }
    
    open func add(node: SingleNode<T>) {
        if count == 0 {
            head = node
        } else {
            var current = head
            while current?.next != nil {
                current = current?.next
            }
            current?.next = node
        }
        
        count += 1
    }
    
    open func prepend(node: SingleNode<T>) {
        node.next = head
        head = node
        
        count += 1
    }
    
    open func removeLast() throws -> SingleNode<T>? {
        if count == 0 {
            throw MyError.runtimeError("Invalid call")
        }
        
        var node: SingleNode<T>?
        if count == 1 {
            node = head
            head = nil
        } else {
            var current = head
            while current?.next != nil {
                node = current
                current = current?.next
            }
            node?.next = nil
            node = current
        }
        
        count -= 1
        
        return node
    }
    
    open func isEmpty() -> Bool {
        return count == 0
    }
}
