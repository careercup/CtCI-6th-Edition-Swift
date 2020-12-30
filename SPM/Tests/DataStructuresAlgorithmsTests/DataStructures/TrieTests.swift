import XCTest
@testable import DataStructuresAlgorithms

open class TrieTests: XCTestCase {
    
    open func testTrie() {
        let trieValue = "Trie"
        let trie = Trie()

        trie.insert(word: trieValue)
        
        XCTAssertFalse(trie.search(word: "T"))
        XCTAssertTrue(trie.search(word: trieValue))
        XCTAssertFalse(trie.search(word: "Triex"))
    }
}
