//
//  GridPathFinder.swift
//  
//
//  Created by Stefan Jaindl on 13.08.20.
//

import Foundation

open class GridPathFinder<T> {
    
    var cellGrid: [[GridCell<T>]]
    
    public init(grid: [[GridCell<T>]]) {
        cellGrid = grid
    }
    
    //Finds a path from the top-left cell to the bottom-right cell, if one exists
    //Path can only go downwards and right
    open func findPath() -> [T]? {
        if cellGrid.isEmpty || cellGrid[0].isEmpty {
            return nil
        }
        
        let rows = cellGrid.count
        let columns = cellGrid[0].count
        let current = cellGrid[0][0]
        let target = cellGrid[rows - 1][columns - 1]
        
        let result = findPath(target: target, current: current)
        
        return result.valid ? result.path.reversed() : nil
    }
    
    private func findPath(target: GridCell<T>, current: GridCell<T>) -> (valid: Bool, path: [T]) {
        //base case
        if current == target {
            return (valid: true, path: [current.value])
        }
        
        //Check right path
        if isInBoundsAndAccessible(row: current.row, column: current.column + 1), !cellGrid[current.row][current.column + 1].checked {
            cellGrid[current.row][current.column + 1].checked = true
            var result = findPath(target: target, current: cellGrid[current.row][current.column + 1])
            if result.valid {
                result.path.append(current.value)
                return result
            }
        }
        
        //Check down path
        if isInBoundsAndAccessible(row: current.row + 1, column: current.column), !cellGrid[current.row + 1][current.column].checked {
            cellGrid[current.row + 1][current.column].checked = true
            var result = findPath(target: target, current: cellGrid[current.row + 1][current.column])
            if result.valid {
                result.path.append(current.value)
                return result
            }
        }
        
        return (false, [])
    }
    
    private func isInBoundsAndAccessible(row: Int, column: Int) -> Bool {
        if row < cellGrid.count && column < cellGrid[0].count {
            return cellGrid[row][column].isAccessible
        }
        
        return false
    }
}

public struct GridCell<T>: Equatable {
    var checked = false
    let value: T
    let isAccessible: Bool
    let row: Int
    let column: Int
    
    public static func == (lhs: GridCell, rhs: GridCell) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
}
