//
//  BestLineSearcher.swift
//  
//
//  Created by Stefan Jaindl on 26.11.20.
//

import Foundation

//Searches for a straight line in a 2D-graph that connects most points of it
open class BestLineSearcher {
    public init() { }
    
    open func bestLine(of graph: TwoDGraph) -> MultiPrecisionLine? {
        guard !graph.points.isEmpty else {
            return nil
        }
        
        var bestPoints: Set<Point> = Set()
        var slopeIntercepts: [SlopeWithIntercept: Set<Point>] = [:]
        
        for firstIndex in 0 ..< graph.points.count {
            let firstPoint = graph.points[firstIndex]
            for secondIndex in firstIndex + 1 ..< graph.points.count {
                let secondPoint = graph.points[secondIndex]
                
                let slope = secondPoint.x == firstPoint.x
                                ? Double.greatestFiniteMagnitude //prevent division by 0 - use greatestFiniteMagnitude as indicator
                                : (secondPoint.y - firstPoint.y) / (secondPoint.x - firstPoint.x)
                
                //One issue with using floating point numbers is inaccuracy of numbers. We could come around this by defining an epsilon value or ceil/round
                let yIntercept: Double
                if slope == Double.greatestFiniteMagnitude {
                    yIntercept = Double.greatestFiniteMagnitude
                } else {
                    let xDiffToYIntercept = firstPoint.x < secondPoint.x ? firstPoint.x : secondPoint.x
                    let minY = firstPoint.y < secondPoint.y ? firstPoint.y : secondPoint.y
                    let direction: Double = firstPoint.y < secondPoint.y ? -1.0 : 1.0
                     yIntercept = minY + direction * slope * xDiffToYIntercept
                }
                
                let slopeWithIntercept = SlopeWithIntercept(slope: slope, yIntercept: yIntercept)
                if var points = slopeIntercepts[slopeWithIntercept] {
                    points.insert(firstPoint)
                    points.insert(secondPoint)
                    slopeIntercepts[slopeWithIntercept] = points
                } else {
                    slopeIntercepts[slopeWithIntercept] = [firstPoint, secondPoint]
                }
                
                if let curPoints = slopeIntercepts[slopeWithIntercept], curPoints.count > bestPoints.count {
                    bestPoints = curPoints
                }
            }
        }
        
        return convertToLine(points: bestPoints)
    }
    
    private func convertToLine(points: Set<Point>) -> MultiPrecisionLine {
        var topPoint = Point(x: Double.leastNonzeroMagnitude, y: Double.leastNonzeroMagnitude)
        var bottomPoint = Point(x: Double.greatestFiniteMagnitude, y: Double.greatestFiniteMagnitude)
        
        points.forEach { point in
            if point.y > topPoint.y {
                topPoint = Point(x: point.x, y: point.y)
            } else if point.y == topPoint.y, point.x > topPoint.x {
                topPoint = Point(x: point.x, y: point.y)
            }
            
            if point.y < bottomPoint.y {
                bottomPoint = Point(x: point.x, y: point.y)
            } else if point.y == bottomPoint.y, point.x < bottomPoint.x {
                bottomPoint = Point(x: point.x, y: point.y)
            }
        }
        
        return MultiPrecisionLine(startPoint: bottomPoint, endPoint: topPoint)
    }
}

public struct TwoDGraph {
    let points: [Point]
}

public struct Point: Hashable {
    let x: Double
    let y: Double
}

public struct SlopeWithIntercept: Hashable {
    let slope: Double
    let yIntercept: Double
}

public struct MultiPrecisionLine: Equatable {
    let startPoint: Point
    let endPoint: Point
}
