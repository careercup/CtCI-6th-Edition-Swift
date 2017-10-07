//
//  Collections.swift
//  X
//
//  Created by Matthew Carroll on 10/7/17.
//  Copyright © 2017 Matthew Carroll. All rights reserved.
//

import Foundation

public extension Collection {
    
    func longerAndShorterCollections(other: Self) -> (longerCollection: Self, shorterCollection: Self) {
        return count > other.count ? (self, other) : (other, self)
    }
}
