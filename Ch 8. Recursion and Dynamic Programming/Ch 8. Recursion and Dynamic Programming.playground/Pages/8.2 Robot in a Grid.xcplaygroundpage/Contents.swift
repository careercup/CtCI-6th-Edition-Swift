import Foundation

/*:
 8.2 Imagine a robot sitting on the upper left corner of a grid with r rows and c columns. The robot can only move in two directions, right and down, certain cells are "off limits" such that the robot cannot step on them. Design an algorithm to find a path for the robot from the top left to the bottom right. 
 */

indirect enum Cell: CustomStringConvertible {
  
  case Clear(coordinate: Coordinate, downCell: Cell?, rightCell: Cell?)
  case Blocked(coordinate: Coordinate, downCell: Cell?, rightCell: Cell?)
  
  var pathToBottomRight: [Coordinate]? {
    if case .Blocked = self {
      return nil
    }
    switch self {
    case .Clear(let coordinate, let downCell, let rightCell):
      if downCell == nil && rightCell == nil {
        return [coordinate]
      }
      if let downPath = downCell?.pathToBottomRight {
        return [coordinate] + downPath
      }
      if let rightPath = rightCell?.pathToBottomRight {
        return [coordinate] + rightPath
      }
      return nil
    default: return nil
    }
  }
  
  var description: String {
    switch self {
    case .Clear(_, _, _): return "|_|"
    default: return "|x|"
    }
  }
}

struct Coordinate: Hashable {
  let x: Int
  let y: Int
}

extension Coordinate: CustomStringConvertible {
  
  var description: String {
    return "\(x) \(y)"
  }
}


func ==(lhs: Coordinate, rhs: Coordinate) ->  Bool {
  
  return lhs.x == rhs.x && lhs.y == rhs.y
}

func ==(lhs: Coordinate, rhs: (Int, Int)) ->  Bool {
  
  return lhs.x == rhs.0 && lhs.y == rhs.1
}

struct Grid {
  
  let cells: [[Cell]]
  
  init(rows: Int, columns: Int, blockedCells: Set<Coordinate>) {
    var cells = [[Cell]]()
    let rows = (0..<rows).reversed()
    rows.forEach { i in
      var row = [Cell]()
      let columns = (0..<columns).reversed()
      
      columns.forEach { j in
        let coordinate = Coordinate(x: i, y: j)
        let rightCell = row.first
        let downCell = cells.first?[j]
        var cell = Cell.Clear(coordinate: coordinate, downCell: downCell, rightCell: rightCell)
        if blockedCells.contains(coordinate) {
          cell = Cell.Blocked(coordinate: coordinate, downCell: downCell, rightCell: rightCell)
        }
        row.insert(cell, at: 0)
      }
      cells.insert(row, at: 0)
    }
    self.cells = cells
  }
  
  var pathToBottomRight: [Coordinate]? {
    return cells.first?.first?.pathToBottomRight
  }
}

extension Grid: CustomStringConvertible {
  
  var description: String {
    var description = ""
    cells.forEach { row in
      description += row.reduce("") { description, cell in description + cell.description }
      description += "\n"
    }
    return description
  }
}

func testGrid(rows: Int, columns: Int, blockCoordinates: [(Int, Int)], expectedPath: [(Int, Int)]) -> Bool {
  var blockedCells = Set<Coordinate>()
  blockCoordinates.forEach { e in
    blockedCells.insert(Coordinate(x: e.0, y: e.1))
  }
  let grid = Grid(rows: rows, columns: columns, blockedCells: blockedCells)
  print("\(grid)")
  let path = grid.pathToBottomRight!
  print("\(path)")
  grid.pathToBottomRight!.enumerated().forEach { i, e in
    assert(e == expectedPath[i])
  }
  return true
}

var blockCoordinates = [(1,0), (2,0), (3,0), (1,1), (2, 1), (3, 1)]
var expectedPath = [(0,0), (0,1), (0,2), (1,2), (2,2), (3,2)]
testGrid(rows: 4, columns: 3, blockCoordinates: blockCoordinates, expectedPath: expectedPath)

blockCoordinates = [(1,0), (0,2), (1,2), (3,1)]
expectedPath = [(0,0), (0,1), (1,1), (2,1), (2,2), (3,2)]
testGrid(rows: 4, columns: 3, blockCoordinates: blockCoordinates, expectedPath: expectedPath)

