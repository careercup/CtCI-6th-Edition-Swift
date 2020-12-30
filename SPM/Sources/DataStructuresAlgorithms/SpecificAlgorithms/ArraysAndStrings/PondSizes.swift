//
//  PondSizes.swift
//  
//
//  Created by Stefan Jaindl on 29.11.20.
//

import Foundation

open class PondSizes {
    public init() { }
    
    //Input is a RxC matrix, where 0 indicates water and everything > 0 is above sea level.
    //Water can be horizontally, vertically and diagonally connected.
    //Returns sizes of connected ponds (water)
    open func sizes(matrix: [[Int]]) -> [Int] {
        guard !matrix.isEmpty, !matrix[0].isEmpty else {
            return []
        }
        
        var marked = [[Bool]](repeating: [Bool](repeating: false, count: matrix[0].count), count: matrix.count)
        var ponds: [Int] = []
        
        for row in 0 ..< matrix.count {
            for column in 0 ..< matrix[0].count {
                if marked[row][column] {
                    continue
                }
                
                if matrix[row][column] == 0 { //Water!
                    ponds.append(pondCountDfs(matrix: matrix, marked: &marked, row: row, column: column))
                }
                
                marked[row][column] = true
            }
        }
        
        return ponds
    }
    
    private func pondCountDfs(matrix: [[Int]], marked: inout [[Bool]], row: Int, column: Int) -> Int {
        guard !marked[row][column] else {
            return 0
        }
        
        marked[row][column] = true
        
        if matrix[row][column] != 0 { //no water here
            return 0
        }
        
        var pondCount = 1
        for neighbour in neighbours(matrix: matrix, row: row, column: column) {
            if !marked[neighbour.row][neighbour.column] {
                pondCount += pondCountDfs(matrix: matrix, marked: &marked, row: neighbour.row, column: neighbour.column)
            }
        }
        
        return pondCount
    }
    
    private func neighbours(matrix: [[Int]], row: Int, column: Int) -> [(row: Int, column: Int)] {
        let rowIndices = [-1, 0, 1]
        let columnIndices = [-1, 0, 1]
        
        var neighbourCells: [(row: Int, column: Int)] = []
        for rowIndex in rowIndices {
            for columnIndex in columnIndices {
                let neighbourColumn = column + columnIndex
                let neighbourRow = row + rowIndex
                if row + rowIndex >= 0, neighbourRow < matrix.count, neighbourColumn >= 0, neighbourColumn < matrix[0].count,
                   !(rowIndex == 0 && columnIndex == 0) {
                    neighbourCells.append((row: neighbourRow, column: neighbourColumn))
                }
            }
        }
        
        return neighbourCells
    }
}
