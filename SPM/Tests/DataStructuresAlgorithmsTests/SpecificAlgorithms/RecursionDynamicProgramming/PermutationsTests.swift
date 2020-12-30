//
//  PermutationsTests.swift
//  
//
//  Created by Stefan Jaindl on 19.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class PermutationsTests: XCTestCase {
    
    open func testPermutationsWithoutDuplicates() {
        let permutationBuilder = Permutations()
        let permutations = permutationBuilder.permutationsWithoutDuplicates(of: "abc")
        
        XCTAssertEqual(permutations, ["cba", "bca", "bac", "cab", "acb", "abc"])
    }
    
    open func testPermutationsWithDuplicates() {
        let permutationBuilder = Permutations()
        
        var permutations = permutationBuilder.permutationsWithDuplicates(of: "cbab")
        XCTAssertEqual(permutations, ["abbc", "abcb", "acbb", "babc", "bacb", "bbac", "bbca", "bcab", "bcba", "cabb", "cbab", "cbba"])
        
        permutations = permutationBuilder.permutationsWithDuplicates(of: "aabaa")
        XCTAssertEqual(permutations, ["aaaab", "aaaba", "aabaa", "abaaa", "baaaa"])
    }
}
