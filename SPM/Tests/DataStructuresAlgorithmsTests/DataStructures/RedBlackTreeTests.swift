import XCTest
@testable import DataStructuresAlgorithms

open class RedBlackTreeTests: XCTestCase {
    
    open func testRedBlackTree() {
        let rootValue = 10
        let tree = RedBlackTree<Int>()

        tree.insert(value: rootValue)
        tree.insert(value: 5)
        tree.insert(value: 20)

        tree.insert(value: 2)
        
        XCTAssertEqual(tree.root?.value, 10)
        XCTAssertEqual(tree.root?.color, .black)

        XCTAssertEqual(tree.root?.left?.value, 5)
        XCTAssertEqual(tree.root?.left?.color, .black)

        XCTAssertEqual(tree.root?.right?.value, 20)
        XCTAssertEqual(tree.root?.right?.color, .black)

        XCTAssertEqual(tree.root?.left?.left?.value, 2)
        XCTAssertEqual(tree.root?.left?.left?.color, .red)
    }
}
