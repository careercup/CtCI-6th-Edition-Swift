//
//  IntersectionFinder.swift
//  
//
//  Created by Stefan Jaindl on 15.11.20.
//

import Foundation

open class IntersectionFinder {
    public init() { }
    
    open func intersection(firstLine: LineSegment, secondLine: LineSegment) -> CGPoint? {
        var changed = true
        
        while changed {
            changed = false
        
            let minXLine = firstLine.from.x <= secondLine.from.x ? firstLine : secondLine
            let maxXLine = firstLine == minXLine ? secondLine : firstLine
            let minYLine = firstLine.from.y <= secondLine.from.y ? firstLine : secondLine
            let maxYLine = firstLine == minXLine ? secondLine : firstLine
            
            //Sanity checks
            if minXLine.to.x < maxXLine.from.x || minYLine.to.y < maxYLine.from.y {
                return nil
            }
            
            //adapt min x
            let minValidX = max(firstLine.from.x, secondLine.from.x)
            let xDiffToMinValidX = minValidX - minXLine.from.x
            if xDiffToMinValidX != 0 {
                if minXLine.from.x > minValidX {
                    return nil //invalid
                }
                
                let yDiffToMinValidX = xDiffToMinValidX * minXLine.slope
                minXLine.from.x = minValidX
                minXLine.from.y += yDiffToMinValidX
                changed = true
            }
            
            //adapt max x
            let maxValidX = min(firstLine.to.x, secondLine.to.x)
            let biggerX = firstLine.to.x > secondLine.to.x ? firstLine : secondLine
            let xDiffToMaxValidX = biggerX.to.x - maxValidX
            if xDiffToMaxValidX != 0 {
                if biggerX.from.x > maxValidX {
                    return nil //invalid
                }
                
                let yDiffToMaxValidX = xDiffToMaxValidX * biggerX.slope
                biggerX.to.x = maxValidX
                biggerX.to.y -= yDiffToMaxValidX
                changed = true
            }
            
            //adapt min y
            let minValidY = max(min(firstLine.from.y, firstLine.to.y), min(secondLine.from.y, secondLine.to.y))
            let smallerY = firstLine.from.y == minValidY || firstLine.to.y == minValidY ? secondLine : firstLine
            let yDiffToMinValidY = minValidY - min(smallerY.from.y, smallerY.to.y)
            if yDiffToMinValidY != 0 {
                let xDiffToMinValidY = yDiffToMinValidY * smallerY.slope
                if smallerY.from.y < smallerY.to.y {
                    if smallerY.to.y < minValidY {
                        return nil //invalid
                    }
                    
                    smallerY.from.y = minValidY
                    smallerY.from.x += xDiffToMinValidY
                } else {
                    if smallerY.from.y < minValidY {
                        return nil //invalid
                    }
                    
                    smallerY.to.y = minValidY
                    smallerY.to.x += xDiffToMinValidY
                }
                changed = true
            }
            
            
            //adapt max y
            let maxValidY = min(max(firstLine.from.y, firstLine.to.y), max(secondLine.from.y, secondLine.to.y))
            let biggerY = firstLine.from.y == maxValidY || firstLine.to.y == maxValidY ? secondLine : firstLine
            let yDiffToMaxValidY = max(biggerY.from.y, biggerY.to.y) - maxValidY
            if yDiffToMaxValidY != 0 {
                let xDiffToMaxValidY = yDiffToMaxValidY * biggerY.slope
                if biggerY.from.y > biggerY.to.y {
                    if biggerY.to.y < maxValidY {
                        return nil //invalid
                    }
                    
                    biggerY.from.y = maxValidY
                    biggerY.from.x += xDiffToMaxValidY
                } else {
                    if biggerY.from.y < maxValidY {
                        return nil //invalid
                    }
                    
                    biggerY.to.y = maxValidY
                    biggerY.to.x -= xDiffToMaxValidY
                }
                changed = true
            }
        }
        
        let minXLine = firstLine.from.x <= secondLine.from.x ? firstLine : secondLine
        let minYLine = firstLine.from.y <= secondLine.from.y ? firstLine : secondLine
        
        let xCenter = (minXLine.from.x + minXLine.to.x) / 2
        let yCenter = (minYLine.from.x + minYLine.to.x) / 2
        
        return CGPoint(x: xCenter, y: yCenter)
    }
}

open class LineSegment: Equatable {
    var from: CGPoint
    var to: CGPoint
    
    init(from: CGPoint, to: CGPoint) {
        self.from = from
        self.to = to
    }
    
    var slope: CGFloat {
        return (to.y - from.y) / (to.x - from.x)
    }
    
    public static func == (lhs: LineSegment, rhs: LineSegment) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to
    }
}
