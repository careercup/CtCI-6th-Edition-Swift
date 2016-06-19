// MARK: Swift implemntation of singly LinkedList 
public class Node<T> {
    public var data: T? = nil
    public var next: Node? = nil
    
    public init (data: T) {
        self.data = data
    }
    
    public func printList() {
        var head = self
        while head.next != nil {
            print(head.data!, terminator: " -> ")
            head = head.next!
        }
        if let data = head.data {
            print(data)
        }
    }
    
    public func append(data: T) {
        let tail = Node(data: data)
        var head = self
        while(head.next != nil) {
            head = head.next!
        }
        head.next = tail
    }
    
    public func copy() -> Node<T> {
        let copy = Node(data: self.data!)
        copy.next = self.next
        return copy
    }
}
