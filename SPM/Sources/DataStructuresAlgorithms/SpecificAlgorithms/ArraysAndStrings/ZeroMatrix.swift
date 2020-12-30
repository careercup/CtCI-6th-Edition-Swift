//  ZeroMatrix.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 19.05.20.
//

import Foundation

open class ZeroMatrix {
    
    public init() { }
    
    open func zeroMatrix(matrix: inout [[Int]]) {
        guard !matrix.isEmpty, !matrix[0].isEmpty else {
            return
        }
        
        //We use the first row and column to zero the matrix in place
        
        //So, first remember whether we have to nullify first row and column
        let nullifyFirstRow = checkNullifyFirstRow(matrix: matrix)
        let nullifyFirstColumn = checkNullifyFirstColumn(matrix: matrix)
        
        //Check remaining cols/rows
        for row in 1 ..< matrix.count {
            for column in 1 ..< matrix[0].count {
                if matrix[row][column] == 0 {
                    matrix[0][column] = 0
                    matrix[row][0] = 0
                }
            }
        }
        
        //Nullify remaining columns
        for column in 1 ..< matrix[0].count {
            if matrix[0][column] == 0 {
                for row in 1 ..< matrix.count {
                    matrix[row][column] = 0
                }
            }
        }
        
        //Nullify remaining rows
        for row in 1 ..< matrix.count {
            if matrix[row][0] == 0 {
                for column in 1 ..< matrix[0].count {
                    matrix[row][column] = 0
                }
            }
        }
        
        if nullifyFirstRow {
            for column in 0 ..< matrix[0].count {
                matrix[0][column] = 0
            }
        }
        
        if nullifyFirstColumn {
            for row in 0 ..< matrix.count {
                matrix[row][0] = 0
            }
        }
    }
    
    private func checkNullifyFirstRow(matrix: [[Int]]) -> Bool {
        for col in 0 ..< matrix[0].count {
            if matrix[0][col] == 0 {
                return true
            }
        }
        
        return false
    }
    
    private func checkNullifyFirstColumn(matrix: [[Int]]) -> Bool {
        for row in 0 ..< matrix.count {
            if matrix[row][0] == 0 {
                return true
            }
        }
        
        return false
    }
}
