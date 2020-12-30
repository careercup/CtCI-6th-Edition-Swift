//  MatrixRotation.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 16.05.20.
//

import Foundation

open class MatrixRotation {
    
    public init() { }
    
    open func rotateRight(array: inout [[Int]]) {
        for offset in 0 ..< array.count / 2 {
            rotateRight(array: &array, offset: offset)
        }
    }
    
    open func rotateRight(array: inout [[Int]], offset: Int) {
        for pos in 0 ..< array.count - 1 - offset * 2 {
            let top = array[offset][offset + pos]
            let right = array[offset + pos][array.count - 1 - offset]
            let bottom = array[array.count - 1 - offset][array.count - 1 - offset - pos]
            let left = array[array.count - 1 - offset - pos][offset]
            
            array[offset][offset + pos] = left //left -> top
            array[offset + pos][array.count - 1 - offset] = top //top -> right
            array[array.count - 1 - offset][array.count - 1 - offset - pos] = right //right -> bottom
            array[array.count - 1 - offset - pos][offset] = bottom //bottom -> left
        }
    }
}
