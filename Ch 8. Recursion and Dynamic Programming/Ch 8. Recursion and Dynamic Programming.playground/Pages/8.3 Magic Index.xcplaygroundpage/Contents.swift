import Foundation

/*:
 8.3 A magic index in an array A[0..n-1] is defined as an index such that A[i] = i. Given a sorted array of distinct integers, write a method to find a magic index in A, if one exists.
 */

extension RandomAccessCollection where Index: BinaryInteger, Index == Iterator.Element {
  
  func magicIndex() -> Index? {
    return magicIndex(low: startIndex, high: index(before: endIndex))
  }
  
  private func magicIndex(low: Index, high: Index) -> Index? {
    guard low <= high else { return nil }
    let mid = (low + high) / 2
    guard self[mid] != mid else { return mid }
    
    let leftIndex = Swift.min(index(before: mid), self[mid])
    if let left = magicIndex(low: low, high: leftIndex) {
      return left
    }
    
    let rightIndex = Swift.max(index(after: mid), self[mid])
    return magicIndex(low: rightIndex, high: high)
  }
}

var a = [3,3,3,4,4]
a.magicIndex
assert(a.magicIndex() == a.index(before: a.endIndex))

a = [-10,-5,2,2,2,3,4,7,9,12,13]
assert(a.magicIndex() == 2)

var count = 10

var negatives = Array(repeating: -1, count: count)
var positives = negatives.enumerated().map({ i, e in Int(arc4random()) + i }).sorted()

negatives.enumerated().forEach { i, e in
  var temp = negatives
  temp.replaceSubrange(i..<temp.endIndex, with: positives[i..<positives.endIndex])
  temp[i] = i
  assert(temp.magicIndex() == i, "i = \(i), magic index == \(temp)")
}

