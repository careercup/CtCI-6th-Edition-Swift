import Foundation

//: 2.3 In a singly linked list, delete the node passed in that is between the first and last nodes in the list. You are given access to only the argument node.

extension MutableList {
    
    func deleteHeadNode() {
        guard let tailHead = tail?.head else {
            head = nil
            tail = nil
            return
        }
        head = tailHead
        tail = tail?.tail
    }
}

final class MutableList<Element>: ExpressibleByArrayLiteral {
    
    fileprivate(set) var head: Element?
    fileprivate(set) var tail: MutableList?
    
    convenience init(arrayLiteral: Element...) {
        self.init(array: arrayLiteral)
    }
    
    init(array: [Element]) {
        let list = array.reversed().reduce(MutableList()) {
            MutableList(head: $1, tail: $0)
        }
        head = list.head
        tail = list.tail
    }
    
    init() {
        head = nil
        tail = nil
    }
    
    init(head: Element, tail: MutableList<Element>) {
        self.head = head
        self.tail = tail
    }
    
    func insert(element: Element) -> MutableList {
        return MutableList(head: element, tail: self)
    }
}

extension MutableList {
    
    var description: String {
        guard let head = head else { return "nil" }
        let description = "\(head)"
        switch tail {
        case .some(let tail): return description + " -> " + tail.description
        default: return description + " -> " + "nil"
        }
    }
}

func testDeleteHeadNode() {
    var characters = ["a", "b", "c", "d", "e"]
    var list = MutableList(array: characters)
    list.tail?.tail?.description
    
    characters.remove(at: 2)
    list.tail?.tail?.deleteHeadNode()
    list.description
    characters.forEach { x in
        assert(x == list.head)
        list = list.tail!
    }
}

testDeleteHeadNode()

