//
//  LangthonsCell.swift
//  
//
//  Created by Stefan Jaindl on 01.12.20.
//

import Foundation

open class Langthons {
    public init() {
        grid[antPosition] = Cell(color: randomColor(), coordinate: GridCoordinate(x: 0, y: 0))
    }
    
    static let initialDirection = Direction.right
    var ant = Ant(direction: initialDirection)
    var antPosition = GridCoordinate(x: 0, y: 0)
    var grid: [GridCoordinate: Cell] = [:]
    
    func performMoves(kMoves: Int) -> [Cell] {
        var movesLeft = kMoves
        
        while movesLeft > 0 {
            performSingleMove()
            movesLeft -= 1
        }
        
        return buildGrid()
    }
    
    private func performSingleMove() {
        var currentCell = grid[antPosition]!
        
        currentCell.flipColor()
        
        switch currentCell.color {
        case .white:
            ant.go(to: .right)
        case .black:
            ant.go(to: .left)
        }
        
        let nextCoordinate = getNextCoordinate()
        let nextCell = grid[nextCoordinate] ?? Cell(color: randomColor(), coordinate: nextCoordinate)
        
        antPosition = nextCoordinate
        grid[nextCoordinate] = nextCell
    }
    
    private func getNextCoordinate() -> GridCoordinate {
        let nextCoordinate: GridCoordinate
        
        switch ant.direction {
        case .bottom:
            nextCoordinate = GridCoordinate(x: antPosition.x - 1, y: antPosition.y)
        case .top:
            nextCoordinate = GridCoordinate(x: antPosition.x + 1, y: antPosition.y)
        case .left:
            nextCoordinate = GridCoordinate(x: antPosition.x, y: antPosition.y - 1)
        case .right:
            nextCoordinate = GridCoordinate(x: antPosition.x, y: antPosition.y + 1)
        }
        
        return nextCoordinate
    }
    
    private func randomColor() -> Color {
        let random = Int.random(in: 0 ..< 2)
        return Color(rawValue: random)!
    }
    
    private func buildGrid() -> [Cell] {
        let cellsToSort = grid.map { $0.value }
        
        let sorted = cellsToSort.sorted(by: { (lhs, rhs) in
            lhs.coordinate > rhs.coordinate
        })
        
        return sorted
    }
}

extension Langthons {
    public enum Direction: Int {
        case right
        case bottom
        case left
        case top
    }
    
    public struct GridCoordinate: Hashable, Comparable {
        let x: Int
        let y: Int
        
        public static func < (lhs: GridCoordinate, rhs: GridCoordinate) -> Bool {
            if lhs.y != rhs.y {
                return lhs.y < rhs.y
            }
            return lhs.x < rhs.x
        }
        
        public static func == (lhs: GridCoordinate, rhs: GridCoordinate) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }
    }
    
    public struct Ant {
        var direction: Direction
        
        public mutating func go(to direction: Direction) {
            switch direction {
            case .left:
                switch self.direction {
                case .right:
                    self.direction = .top
                default:
                    self.direction = Direction(rawValue: self.direction.rawValue - 1)!
                }
            case .right:
                switch self.direction {
                case .top:
                    self.direction = .right
                default:
                    self.direction = Direction(rawValue: self.direction.rawValue + 1)!
                }
            default:
                debugPrint("Unsupported ant move")
            }
        }
    }
    
    public enum Color: Int {
        case black
        case white
    }
    
    public struct Cell {
        var color: Color
        let coordinate: GridCoordinate
        
        public mutating func flipColor() {
            color = color == Color.black ? Color.white : Color.black
        }
    }
}
