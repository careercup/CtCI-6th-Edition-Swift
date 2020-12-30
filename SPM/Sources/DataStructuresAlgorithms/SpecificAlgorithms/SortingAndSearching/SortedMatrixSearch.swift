//
//  SortedMatrixSearch.swift
//  
//
//  Created by Stefan Jaindl on 26.09.20.
//

import Foundation

open class SortedMatrixSearch<T: Comparable> {
    public init() { }
    
    //Searches a path through the matrix: O(M * N) average case. O(M * N) additional space.
    open func sortedMatrixSearch(matrix: [[T]], searched: T) -> Bool {
        guard !matrix.isEmpty, !matrix[0].isEmpty else {
            return false
        }
        
        let columnCount = matrix[0].count
        for row in 0 ..< matrix.count {
            if matrix[row].count != columnCount {
                //Matrix has different amount of columns!
                return false
            }
        }
        
        var lookupMatrix: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: columnCount), count: matrix.count)
        
        return containsRecursive(matrix: matrix, searched: searched, row: 0, column: 0, lookupMatrix: &lookupMatrix)
    }
    
    private func containsRecursive(matrix: [[T]], searched: T, row: Int, column: Int, lookupMatrix: inout [[Bool]]) -> Bool {
        lookupMatrix[row][column] = true
        let matrixValue = matrix[row][column]
        
        if matrixValue > searched {
            return false
        }
        
        if matrixValue == searched {
            return true
        }
        
        var submatch = false
        if isInBounds(matrix: matrix, row: row + 1, column: column), !lookupMatrix[row + 1][column] {
            submatch = containsRecursive(matrix: matrix, searched: searched, row: row + 1, column: column, lookupMatrix: &lookupMatrix)
        }
        if !submatch, isInBounds(matrix: matrix, row: row, column: column + 1), !lookupMatrix[row][column + 1] {
            submatch = containsRecursive(matrix: matrix, searched: searched, row: row, column: column + 1, lookupMatrix: &lookupMatrix)
        }
        
        return submatch
    }
    
    private func isInBounds(matrix: [[T]], row: Int, column: Int) -> Bool {
        return row >= 0 && column >= 0 && row < matrix.count && column < matrix[0].count
    }
    
    // Faster Implementation and without additional space.
    //Searches from center of matrix onwards to 4 sides (at least eliminates one quarter at each rec. call). No additional space.
    open func sortedMatrixSearchFaster(matrix: [[T]], searched: T) -> Bool {
        guard !matrix.isEmpty, !matrix[0].isEmpty else {
            return false
        }
        
        let columnCount = matrix[0].count
        for row in 0 ..< matrix.count {
            if matrix[row].count != columnCount {
                //Matrix has different amount of columns!
                return false
            }
        }
        
        let from = Coordinate(row: 0, column: 0)
        let to = Coordinate(row: matrix.count - 1, column: columnCount - 1)
        return containsRecursiveFaster(matrix: matrix, searched: searched, from: from, to: to)
    }
    
    private func containsRecursiveFaster(matrix: [[T]], searched: T, from: Coordinate, to: Coordinate) -> Bool {
        let currentValue = value(of: matrix, at: from)
        if currentValue == searched { //found
            return true
        }
        
        if currentValue > searched { //not in matrix
            return false
        }
        
        if (from == to) { //only 1 field left
            return false
        }
        
        if from.column == to.column { //only 1 column left, move on to next row
            let newFrom = Coordinate(row: from.row + 1, column: from.column)
            return containsRecursiveFaster(matrix: matrix, searched: searched, from: newFrom, to: to)
        }
        
        if from.row == to.row { //only 1 row left, move on to next column
            let newFrom = Coordinate(row: from.row, column: from.column + 1)
            return containsRecursiveFaster(matrix: matrix, searched: searched, from: newFrom, to: to)
        }
        
        guard let partition = partitionDiagonally(matrix: matrix, searched: searched, from: from, to: to) else {
            return false
        }
        
        if partition.found {
            return true
        }
        
        var found = false
        //search top right
        let topRightFrom = Coordinate(row: from.row, column: partition.bottomRightCoordinate.column)
        let topRightTo = Coordinate(row: partition.topLeftCoordinate.row, column: to.column)
        if isInBounds(matrix: matrix, coordinate: topRightFrom)  {
            found = containsRecursiveFaster(matrix: matrix, searched: searched, from: topRightFrom, to: topRightTo)
        }
        
        //search bottom left
        let bottomLeftFrom = Coordinate(row: partition.bottomRightCoordinate.row, column: from.column)
        let bottomLeftTo = Coordinate(row: to.row, column: partition.topLeftCoordinate.column)
        if !found && isInBounds(matrix: matrix, coordinate: bottomLeftFrom) {
            found = containsRecursiveFaster(matrix: matrix, searched: searched, from: bottomLeftFrom, to: bottomLeftTo)
        }
        
        return found
    }
    
    private func partitionDiagonally(matrix: [[T]], searched: T, from: Coordinate, to: Coordinate) -> (topLeftCoordinate: Coordinate, bottomRightCoordinate: Coordinate, found: Bool)? {
        if value(of: matrix, at: from) > searched {
            //searched value lower than any in  matrix
            return nil
        }
        
        if value(of: matrix, at: to) < searched {
            //searched value higher than any in  matrix
            return nil
        }
        
        //find partitioning element, where first coordinate < searched and last coordinate > searched.
        //Or return true if element found
        
        let maxAllowedDiff = min(to.column - from.column, to.row - from.row)
        var topLeftCoordinate = from
        var bottomRightCoordinate = to
        let bottomRightCoordinateToCompare = Coordinate(row: min(to.row, from.row + maxAllowedDiff), column: min(to.column, from.column + maxAllowedDiff))
        while topLeftCoordinate < bottomRightCoordinate {
            let center = coordinatesCenter(from: topLeftCoordinate, to: bottomRightCoordinateToCompare)
            let diff = center.column - topLeftCoordinate.column
            let valueAtCenter = value(of: matrix, at: center)
            let valueAtTopLeft = value(of: matrix, at: topLeftCoordinate)
            let valueAtBottomRight = value(of: matrix, at: bottomRightCoordinate)
            let valueAtBottomRightToCompare = value(of: matrix, at: bottomRightCoordinateToCompare)
            
            if valueAtCenter == searched || valueAtTopLeft == searched || valueAtBottomRight == searched || valueAtBottomRightToCompare == searched {
                //value found
                return (center, center, true)
            } else if bottomRightCoordinate.column - topLeftCoordinate.column == 1
            && valueAtTopLeft < searched && valueAtBottomRight > searched, valueAtTopLeft < searched && valueAtBottomRight > searched {
                //coordinates are next to each other and searched value is in between
                break
            } else if valueAtCenter < searched {
                //go right/down
                topLeftCoordinate = Coordinate(row: topLeftCoordinate.row + diff, column: topLeftCoordinate.column + diff)
            } else { //valueAtCenter < searched
                //go left/up
                bottomRightCoordinate = Coordinate(row: center.row, column: center.column)
            }
        }
        
        return (topLeftCoordinate, bottomRightCoordinate, false)
    }
    
    private func isInBounds(matrix: [[T]], coordinate: Coordinate) -> Bool {
        return coordinate.row >= 0 && coordinate.column >= 0 && coordinate.row < matrix.count && coordinate.column < matrix[0].count
    }
    
    private func value(of matrix: [[T]], at coordinate: Coordinate) -> T {
        return matrix[coordinate.row][coordinate.column]
    }
    
    private func coordinatesCenter(from: Coordinate, to: Coordinate) -> Coordinate {
        let centerRow = (from.row + to.row) / 2
        let centerColumn = (from.column + to.column) / 2
        
        return Coordinate(row: centerRow, column: centerColumn)
    }
}

private struct Coordinate: Equatable, Comparable {
    var row: Int
    var column: Int
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
    
    static func < (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.row < rhs.row && lhs.column < rhs.column
    }
}
