//
//  T9KeyboardTests.swift
//  
//
//  Created by Stefan Jaindl on 30.11.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class T9KeyboardTests: XCTestCase {
    
    open func testT9Keyboard() throws {
        let validWords = Trie()
        
        validWords.insert(word: "adgj")
        validWords.insert(word: "agdjux")
        validWords.insert(word: "agd")
        validWords.insert(word: "adgjaaa")
        
        let keyboard = T9Keyboard(validWords: validWords)
        
        let digits = [2, 3, 4, 5]
        
        let autocompleted = try keyboard.autocomplete(for: digits)
        
        XCTAssertEqual(autocompleted, ["adgj", "adgjaaa"])
    }
}
