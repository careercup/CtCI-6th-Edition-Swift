/*:
 10.9 Sorted Matrix Search: Given an M x N matrix in which each row and column are sorted in ascending order, find the given element.
 */
extension RandomAccessCollection where Iterator.Element: RandomAccessCollection, Iterator.Element.Iterator.Element: Comparable, Iterator.Element.Index == Index {
  
  func binarySearch(x: Iterator.Element.Iterator.Element) -> (Index, Index)? {
    return binarySearch(x: x, rowLow: startIndex, rowHigh: index(before: endIndex), columnLow: self[startIndex].startIndex, columnHigh: self[startIndex].index(before: self[startIndex].endIndex))
  }
  
  private func binarySearch(x: Iterator.Element.Iterator.Element, rowLow: Index, rowHigh: Index, columnLow: Index, columnHigh: Index) -> (Index, Index)? {
    
    guard rowLow <= rowHigh && columnLow <= columnHigh else { return nil }
    let rowMid = index(rowLow, offsetBy: distance(from: rowLow, to: rowHigh) / 2)
    let columnMid = index(columnLow, offsetBy: distance(from: columnLow, to: columnHigh) / 2)
    let candidate = self[rowMid][columnMid]
    
    if candidate < x {
      let nextMidRow = binarySearch(x: x, rowLow: index(after: rowMid), rowHigh: rowHigh, columnLow: columnLow, columnHigh: columnHigh)
      return nextMidRow ?? binarySearch(x: x, rowLow: rowLow, rowHigh: rowHigh, columnLow: index(after: columnMid), columnHigh: columnHigh)
    }
    else if x < candidate {
      let previousMidRow = binarySearch(x: x, rowLow: rowLow, rowHigh: index(before: rowMid), columnLow: columnLow, columnHigh: columnHigh)
      return previousMidRow ?? binarySearch(x: x, rowLow: rowLow, rowHigh: rowHigh, columnLow: columnLow , columnHigh: index(before: columnMid))
    }
    else {
      return (rowMid, columnMid)
    }
  }
}

var r1 = [0,2,4,6]
var r2 = [3,5,7,9]
var r3 = [8,10,12,14]
var a2 = [r1,r2,r3]
assert(a2.binarySearch(x: 7)! == (1,2))


