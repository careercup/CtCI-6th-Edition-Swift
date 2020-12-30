//
//  MaxBlack.swift
//  
//
//  Created by Stefan Jaindl on 19.12.20.
//

import Foundation
 
open class MaxBlack {
    public init() { }
    
    open func maxBorder(of square: BlackWhiteSquare) -> SubSquare? {
        var len = square.cells.count
        let count = square.cells.count
        let blackRowCounts = blackRightRowCounts(of: square)
        let blackColCounts = blackBottomColCounts(of: square)
        
        while len > 0 {
            for row in 0 ... count - len {
                for col in 0 ... count - len {
                    let cell = SubSquare(topLeft: CellIndex(row: row, col: col), bottomRight: CellIndex(row: row + len - 1, col: col + len - 1))
                    if isAllBlackBorder(square: square, cell: cell, blackRowCounts: blackRowCounts, blackColCounts: blackColCounts, len: len) {
                        return cell
                    }
                }
            }
            
            len -= 1
        }
        
        return nil
    }
    
    private func blackRightRowCounts(of square: BlackWhiteSquare) -> [CellIndex: Int] {
        var rowIndex = square.cells.count - 1
        var rowRightCounts: [CellIndex: Int] = [:]
        
        while rowIndex >= 0 {
            var blackCount = 0
            var colIndex = square.cells.count - 1
            
            while colIndex >= 0 {
                rowRightCounts[CellIndex(row: rowIndex, col: colIndex)] = blackCount
                if square.cells[rowIndex][colIndex].color == .black {
                    blackCount += 1
                }
                colIndex -= 1
            }
            
            rowIndex -= 1
        }
        
        return rowRightCounts
    }
    
    private func blackBottomColCounts(of square: BlackWhiteSquare) -> [CellIndex: Int] {
        var colIndex = square.cells.count - 1
        var colBottomCounts: [CellIndex: Int] = [:]
        
        while colIndex >= 0 {
            var blackCount = 0
            var rowIndex = square.cells.count - 1
            
            while rowIndex >= 0 {
                colBottomCounts[CellIndex(row: rowIndex, col: colIndex)] = blackCount
                if square.cells[rowIndex][colIndex].color == .black {
                    blackCount += 1
                }
                rowIndex -= 1
            }
            
            colIndex -= 1
        }
        
        return colBottomCounts
    }
    
    private func isAllBlackBorder(square: BlackWhiteSquare, cell: SubSquare, blackRowCounts: [CellIndex: Int], blackColCounts: [CellIndex: Int], len: Int) -> Bool {
        let minRow = cell.topLeft.row
        let maxRow = cell.bottomRight.row
        let minCol = cell.topLeft.col
        let maxCol = cell.bottomRight.col
        
        let topLeftCell = CellIndex(row: minRow, col: minCol)
        let topRightCell = CellIndex(row: minRow, col: maxCol)
        let bottomLeftCell = CellIndex(row: maxRow, col: minCol)
        let bottomRightCell = CellIndex(row: maxRow, col: maxCol)
        
        guard let topLeftRowCount = blackRowCounts[topLeftCell],
              let topRightRowCount = blackRowCounts[topRightCell],
              let bottomLeftRowCount = blackRowCounts[bottomLeftCell],
              let bottomRightRowCount = blackRowCounts[bottomRightCell],
              
              let topLeftColCount = blackColCounts[topLeftCell],
              let topRightColCount = blackColCounts[topRightCell],
              let bottomLeftColCount = blackColCounts[bottomLeftCell],
              let bottomRightColCount = blackColCounts[bottomRightCell] else {
            return false
        }
        
        let blackTopRowCount = topLeftRowCount - topRightRowCount + (square.cells[minRow][minCol].color == .black ? 1 : 0)
        let blackBottomRowCount = bottomLeftRowCount - bottomRightRowCount + (square.cells[maxRow][minCol].color == .black ? 1 : 0)
        
        let blackLeftColCount = topLeftColCount - bottomLeftColCount + (square.cells[minRow][minCol].color == .black ? 1 : 0)
        let blackRightColCount = topRightColCount - bottomRightColCount + (square.cells[minRow][maxCol].color == .black ? 1 : 0)
        
        return blackLeftColCount == len && blackRightColCount == len && blackTopRowCount == len && blackBottomRowCount == len
    }
    
    //Given an NxN matrix of black & white cells, return the max sized black-only square (in O(n^4))
    open func maxBlackFilled(of square: BlackWhiteSquare) -> SubSquare? {
        let count = square.cells.count
        for size in sizes(count: count) {
            let rowSize = size.rowSize
            let colSize = size.colSize
            for row in 0 ... count - rowSize {
                for col in 0 ... count - colSize {
                    let cell = SubSquare(topLeft: CellIndex(row: row, col: col), bottomRight: CellIndex(row: row + rowSize - 1, col: col + colSize - 1))
                    if isAllBlack(square: square, cell: cell) {
                        return cell
                    }
                }
            }
        }
        
        return nil
    }
    
    private func isAllBlack(square: BlackWhiteSquare, cell: SubSquare) -> Bool {
        for row in cell.rowRange {
            for col in cell.colRange {
                if square.cells[row][col].color == .white {
                    return false
                }
            }
        }
        
        return true
    }
    
    private func sizes(count: Int) -> [(rowSize: Int, colSize: Int)] {
        guard count > 0 else {
            return []
        }
        
        var sizes: [(rowSize: Int, colSize: Int)] = []
        for row in 1 ... count {
            for col in 1 ... count {
                sizes.append((rowSize: row, colSize: col))
            }
        }
        
        return sizes.sorted(by: {
            $0.rowSize * $0.colSize > $1.rowSize * $1.colSize
        })
    }
}

public struct BlackWhiteSquare {
    let cells: [[SquareCell]]
}


public struct SquareCell {
    let color: SquareCellColor
}

public struct SubRectangle: Equatable, Hashable {
    let topLeft: CellIndex
    let bottomRight: CellIndex
    
    var width: Int {
        return bottomRight.row - topLeft.row
    }
    
    var height: Int {
        return topLeft.col - bottomRight.col
    }
    
    var rowRange: ClosedRange<Int> {
        return topLeft.row ... bottomRight.row
    }
    
    var colRange: ClosedRange<Int> {
        return topLeft.col ... bottomRight.col
    }
}

public typealias SubSquare = SubRectangle

public enum SquareCellColor {
    case black
    case white
}

public struct CellIndex: Hashable, Equatable {
    let row: Int
    let col: Int
}
