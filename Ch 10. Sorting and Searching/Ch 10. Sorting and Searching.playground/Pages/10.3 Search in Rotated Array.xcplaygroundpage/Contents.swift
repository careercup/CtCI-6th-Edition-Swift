import Foundation

/*:
 10.3 Given a sorted array of n integers that has been rotated an unknown number of times, write code to find the element in the array. You may assume that the array was originally sorted in increasing order.
 */
extension RandomAccessCollection where Iterator.Element: Comparable, Indices.Iterator.Element == Index {
  
  func binarySearchShiftedArray(x: Iterator.Element) -> Index? {
    guard first! > last! else { return binarySearch(x: x) }
    
    guard let minElementIndex = successiveElements (where: { $0 > $1 })?.rightIndex else {
      return binarySearch(x: x)
    }
    
    let leftIndex = binarySearch(x: x, low: minElementIndex, high: index(before: endIndex))
    return leftIndex ?? binarySearch(x: x, low: startIndex, high: index(before: minElementIndex))
  }
}


extension RandomAccessCollection where Iterator.Element: Comparable {
  
  func binarySearch(x: Iterator.Element) -> Index? {
    return binarySearch(x: x, low: startIndex, high: index(before: endIndex))
  }
  
  func binarySearch(x: Iterator.Element, low: Index, high: Index) -> Index? {
    guard low <= high else { return nil }
    
    let mid = index(low, offsetBy: distance(from: low, to: high) / 2)
    if self[mid] < x {
      return binarySearch(x: x, low: index(after: mid), high: high)
    }
    else if self[mid] > x {
      return binarySearch(x: x, low: low, high: index(before: mid))
    }
    else {
      return mid
    }
  }
}

var a = [15,16,19,20,25,1,3,4,5,7,10,14]

a.enumerated().forEach { i, e in
  for shift in 1..<a.endIndex {
    let shiftedArray = Array(a[a.endIndex-shift..<a.endIndex]) + Array(a[0..<a.endIndex-shift])
    let expectedIndex =  i + shift < a.endIndex ? i + shift : i + shift - a.endIndex
    let result = shiftedArray.binarySearchShiftedArray(x: e)
    assert(result == expectedIndex, "expected = \(expectedIndex) actual = \(String(describing: result)) element \(e)", file: "")
  }
}


