//
//  SquareConnector.swift
//  
//
//  Created by Stefan Jaindl on 24.11.20.
//

import Foundation

//Draws a line connecting 2 square centers starting the bottom edge and ending at top edge of second square
open class SquareConnector {
    public init() { }
    
    open func connect(firstSquare: Square, secondSquare: Square) -> Line {
        let centerOfFirstSquare = center(of: firstSquare)
        let centerOfSecondSquare = center(of: secondSquare)
        
        var relevantEdges: [CGPoint] = []
        relevantEdges.append(expand(centerOfFirstSquare: centerOfSecondSquare, centerOfSecondSquare: centerOfFirstSquare, radiusToEdge: firstSquare.radius))
        relevantEdges.append(expand(centerOfFirstSquare: centerOfSecondSquare, centerOfSecondSquare: centerOfFirstSquare, radiusToEdge: -firstSquare.radius))
        relevantEdges.append(expand(centerOfFirstSquare: centerOfFirstSquare, centerOfSecondSquare: centerOfSecondSquare, radiusToEdge: secondSquare.radius))
        relevantEdges.append(expand(centerOfFirstSquare: centerOfFirstSquare, centerOfSecondSquare: centerOfSecondSquare, radiusToEdge: -secondSquare.radius))
        
        let edges = outerEdges(edges: relevantEdges)
        
        return Line(startPoint: edges.bottomEdge, endPoint: edges.topEdge)
    }
    
    private func center(of square: Square) -> CGPoint {
        return CGPoint(x: square.topLeftCorner.x + (square.bottomRightCorner.x - square.topLeftCorner.x) / 2, y: square.bottomRightCorner.y + (square.topLeftCorner.y - square.bottomRightCorner.y) / 2)
    }
    
    private func expand(centerOfFirstSquare: CGPoint, centerOfSecondSquare: CGPoint, radiusToEdge: CGFloat) -> CGPoint {
        let xDirection: CGFloat = centerOfFirstSquare.x < centerOfSecondSquare.x ? -1.0: 1.0
        let yDirection: CGFloat = centerOfFirstSquare.y < centerOfSecondSquare.y ? -1.0 : 1.0
        
        if centerOfFirstSquare.x == centerOfSecondSquare.x {
            //Slope calculation would cause division by zero error.
            //In this special case x axis won't change and y axis will change by half of radius to edge
            return CGPoint(x: centerOfSecondSquare.x, y: centerOfSecondSquare.y + yDirection * radiusToEdge)
        }
        
        let slope = (centerOfFirstSquare.y - centerOfSecondSquare.y) / (centerOfFirstSquare.x - centerOfSecondSquare.x)
        
        if slope == 1 {
            //diagonal slope: x and y edges diagonally reached by line
            return CGPoint(x: centerOfFirstSquare.x + xDirection * radiusToEdge, y: centerOfFirstSquare.y + yDirection * radiusToEdge)
        } else if slope < 1 {
            //flat slope: x axis reached, y partially depending on slope
            let x = centerOfFirstSquare.x + xDirection * radiusToEdge
            let y = centerOfFirstSquare.y + (x - centerOfFirstSquare.x) * slope
            return CGPoint(x: x, y: y)
        } else {
            //big slope: y axis reached, x partially depending on slope
            let y = centerOfFirstSquare.y + yDirection * radiusToEdge
            let x = centerOfFirstSquare.x + (y - centerOfFirstSquare.y) / slope
            return CGPoint(x: x, y: y)
        }
    }
    
    private func outerEdges(edges: [CGPoint]) -> (topEdge: CGPoint, bottomEdge: CGPoint) {
        var topEdge = CGPoint(x: CGFloat.leastNonzeroMagnitude, y: CGFloat.leastNonzeroMagnitude)
        var bottomEdge = CGPoint(x: CGFloat.greatestFiniteMagnitude, y: CGFloat.greatestFiniteMagnitude)
        
        edges.forEach { edge in
            if edge.y > topEdge.y {
                topEdge = edge
            } else if edge.y == topEdge.y, edge.x > topEdge.x {
                topEdge = edge
            }
            
            if edge.y < bottomEdge.y {
                bottomEdge = edge
            } else if edge.y == bottomEdge.y, edge.x < bottomEdge.x {
                bottomEdge = edge
            }
        }
        
        return (topEdge: topEdge, bottomEdge: bottomEdge)
    }
}

public struct Square {
    let topLeftCorner: CGPoint
    let bottomRightCorner: CGPoint
    
    init(topLeftCorner: CGPoint, length: CGFloat) {
        self.topLeftCorner = topLeftCorner
        self.bottomRightCorner = CGPoint(x: topLeftCorner.x + length, y: topLeftCorner.y - length)
    }
    
    var radius: CGFloat {
        return (topLeftCorner.y - bottomRightCorner.y) / 2
    }
}

public struct Line: Equatable {
    let startPoint: CGPoint
    let endPoint: CGPoint
}
