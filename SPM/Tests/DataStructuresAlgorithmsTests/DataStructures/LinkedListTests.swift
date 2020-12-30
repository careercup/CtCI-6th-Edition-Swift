import XCTest
@testable import DataStructuresAlgorithms

open class LinkedListTests: XCTestCase {
    
    open func testLinkedList() {
        let list = DoubleLinkedList<Int>()

        let node1 = Node(val: 1)
        list.add(node: node1)

        let node2 = Node(val: 2)
        list.add(node: node2)
        
        XCTAssertEqual(list.head?.val, 1)
        XCTAssertEqual(list.head?.next?.val, 2)
        XCTAssertEqual(list.tail?.val, 2)
        XCTAssertNil(list.tail?.prev?.prev?.val)
        XCTAssertEqual(list.count, 2)

        list.removeByKey(val: 1)
        XCTAssertEqual(list.head?.val, 2)
        XCTAssertNil(list.head?.next?.val)
        XCTAssertEqual(list.tail?.val, 2)
        XCTAssertNil(list.tail?.prev?.prev?.val)
        XCTAssertEqual(list.count, 1)
    }
}
