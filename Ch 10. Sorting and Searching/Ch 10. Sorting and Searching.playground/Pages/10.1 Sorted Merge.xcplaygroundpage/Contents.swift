import Foundation

/*:
 10.1 Given to sorted arrays A and B, merge B into A in sorted order.
 */
extension RandomAccessCollection where Iterator.Element: Comparable {
  
  func mergeSorted<C: RandomAccessCollection>(sorted: C) -> [Iterator.Element]
    where C.Iterator.Element == Iterator.Element, C.Index == Index {
      
      var merged = Array(self) + Array(sorted)
      var mi = merged.startIndex
      var i = startIndex
      var si = sorted.startIndex
      
      while i < endIndex && si < sorted.endIndex {
        if self[i] <= sorted[si] {
          merged[mi] = self[i]
          i = index(after: i)
        }
        else {
          merged[mi] = sorted[si]
          si = sorted.index(after: si)
        }
        mi += 1
      }
      
      for x in self[i..<endIndex] {
        merged[mi] = x
        mi += 1
      }
      return merged
  }
}

var a = (0..<10).map { _ in 100.arc4random_uniform() }
var b = (0..<10).map { _ in 100.arc4random_uniform() }

a = a.sorted()
b = b.sorted()

var m1 = a.mergeSorted(sorted: b)
var m2 = (a + b).sorted()
assert(m1 == m2)
