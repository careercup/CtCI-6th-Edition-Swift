//
//  QueensOnChessboard.swift
//
//
//  Created by Stefan Jaindl on 25.08.20.
//

import Foundation

open class QueensOnChessboard {
    
    private let boardLength: Int
    
    public init(boardLength: Int = 8) {
        self.boardLength = boardLength
    }
    
    //return all possible arrangements of 8 queens on 8x8 chessboard with the following limitations:
    /*
     only 1 queen in a row
     only 1 queen in a column
     only 1 queen in each diagonal
     */
    
    open func queenArrangements(partial: [(row: Int, column: Int)] = [], row: Int = 0) -> [[(row: Int, column: Int)]] {
        if row >= boardLength {
            return [partial]
        }
        
        var arrangements: [[(Int, Int)]] = []
        for column in 0 ..< boardLength {
            if isValid(row: row, column: column, partial: partial) {
                var newArrangement = partial
                newArrangement.append((row, column))
                let arrangementForColumn = queenArrangements(partial: newArrangement, row: row + 1)
                arrangements.append(contentsOf: arrangementForColumn)
            }
        }
        
        return arrangements
    }
    
    private func isValid(row: Int, column: Int, partial: [(row: Int, column: Int)]) -> Bool {
        if row >= boardLength || column >= boardLength {
            return false
        }
        
        //no queens placed for row 0, that index is always valid, and is skipped in loop
        for currentRow in 0 ..< row {
            if partial[currentRow].column == column {
                return false //column already used
            }
            
            let rowDistance = row - currentRow
            let leftDiagonalIndex = column - rowDistance
            let rightDiagonalIndex = column + rowDistance
            if partial[currentRow].column == leftDiagonalIndex || partial[currentRow].column == rightDiagonalIndex {
                return false //diagonal occupied
            }
        }
        
        return true
    }
}
