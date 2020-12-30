//
//  MaxMatrixSum.swift
//  
//
//  Created by Stefan Jaindl on 20.12.20.
//

import Foundation

open class MaxMatrixSum {
    
    public init() { }
    
    //Finds submatrix of given matrix with positive and negative int's in O(n^4) time & O(n^2) space
    open func maxSum(of matrix: [[Int]]) -> SubRectangle? {
        guard !matrix.isEmpty, matrix.count == matrix[0].count else {
            return nil
        }
        
        let subsumsFromOrigin: [[Int]] = computeSumsFromTopLeft(of: matrix)
        var maxSum = Int.min
        var maxRectangle: SubRectangle? = nil
        
        for rowSize in 1 ... matrix.count {
            let maxValidStartRow = matrix.count - rowSize
            for colSize in 1 ... matrix[0].count {
                let maxValidStartColumn = matrix[0].count - colSize
                for topRow in 0 ... maxValidStartRow {
                    for leftCol in 0 ... maxValidStartColumn {
                        let bottomRow = topRow + rowSize - 1
                        let rightCol = leftCol + colSize - 1
                        
                        let fromIndex = CellIndex(row: topRow, col: leftCol)
                        let toIndex = CellIndex(row: bottomRow, col: rightCol)
                        let sum = subsum(from: fromIndex, to: toIndex, subsumsFromOrigin: subsumsFromOrigin)
                        
                        if sum > maxSum {
                            maxSum = sum
                            maxRectangle = SubRectangle(topLeft: fromIndex, bottomRight: toIndex)
                        }
                    }
                }
            }
        }
        
        return maxRectangle
    }
    
    private func subsum(from: CellIndex, to: CellIndex, subsumsFromOrigin: [[Int]]) -> Int {
        var sum = subsumsFromOrigin[to.row][to.col]
        
        if from.row > 0 {
            sum -= subsumsFromOrigin[from.row - 1][to.col]
        }
        if from.col > 0 {
            sum -= subsumsFromOrigin[to.row][from.col - 1]
        }
        if from.row > 0, from.col > 0 {
            sum += subsumsFromOrigin[from.row - 1][from.col - 1]
        }
        
        return sum
    }
    
    private func computeSumsFromTopLeft(of matrix: [[Int]]) -> [[Int]] {
        var subsums: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: matrix[0].count), count: matrix.count)
        
        for row in 0 ..< matrix.count {
            for col in 0 ..< matrix[0].count {
                var sum = matrix[row][col]
                if row > 0, col > 0 {
                    sum -= subsums[row - 1][col - 1]
                }
                if row > 0 {
                    sum += subsums[row - 1][col]
                }
                if col > 0 {
                    sum += subsums[row][col - 1]
                }
                subsums[row][col] = sum
            }
        }
        
        return subsums
    }
}
