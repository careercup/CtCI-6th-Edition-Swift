//
//  SparseMatrixTests.swift
//  
//
//  Created by Stefan Jaindl on 23.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class SparseMatrixTests: XCTestCase {
    
    open func testSparseMatrix() {
        let sparser = SparseMatrix()
        
        let documents = [
            SparseDocument(id: 13, words: [14, 15, 100, 9, 3]),
            SparseDocument(id: 16, words: [12, 1, 9, 3, 5]),
            SparseDocument(id: 19, words: [15, 29, 2, 6, 8, 7]),
            SparseDocument(id: 24, words: [7, 10])
        ]
        
        let similarities = sparser.similarity(of: documents)
        
        XCTAssertTrue(similarities.contains(Similarity(documents: DocumentPair(firstId: 13, secondId: 16), similarity: 0.25)))
        XCTAssertTrue(similarities.contains(Similarity(documents: DocumentPair(firstId: 13, secondId: 19), similarity: 0.1)))
        XCTAssertTrue(similarities.contains(Similarity(documents: DocumentPair(firstId: 19, secondId: 24), similarity: 0.14285714285714285)))
    }
}
