import Foundation

//: 16.3 Given two straight line segments, compute the point of intersection, if any.
class Point {
    var x: Double
    var y: Double
    
    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
    
    static func swap(lhs: inout Point, rhs: inout Point) {
        Swift.swap(&lhs.x, &rhs.x)
        Swift.swap(&lhs.y, &rhs.y)
    }
}

class Line {
    let slope: Double
    let yIntercept: Double
    
    init(_ start: Point, _ end: Point) {
        let deltaY = end.y - start.y
        let deltaX = end.x - start.x
        
        if deltaX == 0.0 {
            self.slope = .infinity
        } else {
            self.slope = deltaY / deltaX
        }
        
        self.yIntercept = end.y - slope * end.x
    }
}

func isBetween(start: Double, middle: Double, end: Double) -> Bool {
    if start > end {
        return end <= middle && middle <= start
    } else {
        return start <= middle && middle <= end
    }
}

func isBetween(start: Point, middle: Point, end: Point) -> Bool {
    return isBetween(start: start.x, middle: middle.x, end: end.x) &&
        isBetween(start: start.y, middle: middle.y, end: end.y)
}

func intersection(start1: Point, end1: Point, start2: Point, end2: Point) -> Point? {
    // Create local variables
    var start1 = start1
    var start2 = start2
    var end1 = end1
    var end2 = end2
    
    // Rearrange them so the lower values are in the start
    if start1.x > end1.x {
        Point.swap(lhs: &start1, rhs: &end1)
    }
    if start2.x > end2.x {
        Point.swap(lhs: &start2, rhs: &end2)
    }
    if start1.x > start2.x {
        Point.swap(lhs: &start1, rhs: &start2)
        Point.swap(lhs: &end1, rhs: &end2)
    }
    
    let line1 = Line(start1, end1)
    let line2 = Line(start2, end2)
    
    // Check for slop and same yIntercept
    if line1.slope == line2.slope {
        if line1.yIntercept == line2.yIntercept && isBetween(start: start1, middle: start2, end: end1) {
            return start2
        } else {
            return nil
        }
    }
    
    // Use line equation to get intersection
    let x = (line2.yIntercept - line1.yIntercept) / (line1.slope - line2.slope)
    let y = x * line1.slope + line1.yIntercept
    let intersection = Point(x, y)
    
    if isBetween(start: start1, middle: intersection, end: end1) &&
        isBetween(start: start2, middle: intersection, end: end2) {
        return intersection
    }
    
    return nil
}

let start1 = Point(15, 10)
let end1 = Point(49, 25)
let start2 = Point(29, 5)
let end2 = Point(32, 32)

let answer = intersection(start1: start1, end1: end1, start2: start2, end2: end2)
if let answer = answer {
    print("Intersection at point [\(answer.x), \(answer.y)]")
} else {
    print("No intersetion between two lines")
}
