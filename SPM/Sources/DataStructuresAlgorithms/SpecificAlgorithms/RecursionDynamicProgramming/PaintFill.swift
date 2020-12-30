//
//  PaintFill.swift
//  
//
//  Created by Stefan Jaindl on 24.08.20.
//

import Foundation

//Paints surrounding area using BFS with a queue
open class PaintFill {
    public init() { }
    
    let neighbourCoords = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
    
    open func paintFill(screen: inout [[CGColor]], point: Point, newColor: CGColor) throws {
        if screen.count == 0 || !isInBounds(point: point, xLen: screen.count, yLen: screen[0].count) || screen[Int(point.x)][Int(point.y)] == newColor {
            return
        }
        
        let queue = Queue<Point>()
        queue.enqueue(val: point)
        let originalColor = screen[Int(point.x)][Int(point.y)]
        
        while !queue.isEmpty() {
            let current = try queue.dequeue()
            screen[Int(current.x)][Int(current.y)] = newColor
            
            for neighbour in neighboursToFill(color: originalColor, point: current, screen: &screen) {
                queue.enqueue(val: neighbour)
            }
        }
    }
    
    private func neighboursToFill(color: CGColor, point: Point, screen: inout [[CGColor]]) -> [Point] {
        var neighbours: [Point] = []
        
        for coord in neighbourCoords {
            let neighbourCoord = Point(x: Double(coord.0) + point.x, y: Double(coord.1) + point.y)
            if isInBounds(point: neighbourCoord, xLen: screen.count, yLen: screen[0].count), screen[Int(neighbourCoord.x)][Int(neighbourCoord.y)] == color {
                neighbours.append(neighbourCoord)
            }
        }
        
        return neighbours
    }
    
    private func isInBounds(point: Point, xLen: Int, yLen: Int) -> Bool {
        let x = Int(point.x)
        let y = Int(point.y)
        
        return x >= 0 && y >= 0 && x < xLen && y < yLen
    }
}
