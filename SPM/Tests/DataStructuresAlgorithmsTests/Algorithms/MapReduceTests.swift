//
//  MapReduce.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 08.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MapReduceTests: XCTestCase {
    
    open func testMapReduceMock() {
        let words = ["Test", "document", "for", "map", "reduce", "Lorem", "Ipsum", "Dolores", "map", "map", "reduce"]
        let document = Document(words: words)
        let mapReduce = MapReduceWordCount()
        
        mapReduce.map(document: document)
        mapReduce.shuffleAndSort()
        
        if mapReduce.partialResults.count > 0 {
            var currentKey = mapReduce.partialResults[0].key
            var currentResults: [Result] = []
            
            for result in mapReduce.partialResults {
                if result.key == currentKey {
                    currentResults.append(result)
                } else {
                    mapReduce.reduce(partialResults: currentResults)
                    currentKey = result.key
                    currentResults = []
                    currentResults.append(result)
                }
            }
        }
        
        let reducedWords = mapReduce.finalResults.compactMap { reduced in
            return "\(reduced.key): \(reduced.value)"
        }
        
        XCTAssertEqual(reducedWords[0], "Dolores: 1")
        XCTAssertEqual(reducedWords[1], "Ipsum: 1")
        XCTAssertEqual(reducedWords[2], "Lorem: 1")
        XCTAssertEqual(reducedWords[3], "Test: 1")
        XCTAssertEqual(reducedWords[4], "document: 1")
        XCTAssertEqual(reducedWords[5], "for: 1")
        XCTAssertEqual(reducedWords[6], "map: 3")
    }
}
