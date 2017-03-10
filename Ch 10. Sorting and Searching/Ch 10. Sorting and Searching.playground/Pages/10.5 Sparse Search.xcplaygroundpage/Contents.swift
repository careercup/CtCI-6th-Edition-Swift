import Foundation

/*:
 10.5 Given a sorted array of strings that is interspersed with empty strings, return the index of the given string.
 */
extension RandomAccessCollection where Iterator.Element: Comparable {
  
  func sparseSearchFor(x: Iterator.Element, ignoreElement: Iterator.Element) -> Index? {
    return binarySearch(x: x, ignoreElement: ignoreElement, low: startIndex, high: index(before: endIndex))
  }
  
  private func binarySearch(x: Iterator.Element, ignoreElement: Iterator.Element, low: Index, high: Index) -> Index? {
    guard low <= high else { return nil }
    
    let mid = index(low, offsetBy: distance(from: low, to: high) / 2)
    
    if self[mid] == ignoreElement && x != ignoreElement {
      let leftIndex = binarySearch(x: x, ignoreElement: ignoreElement, low: low, high: index(before: mid))
      return leftIndex ?? binarySearch(x: x, ignoreElement: ignoreElement, low: index(after: mid), high: high)
    }
    else if self[mid] < x {
      return binarySearch(x: x, ignoreElement: ignoreElement, low: index(after: mid), high: high)
    }
    else if self[mid] > x {
      return binarySearch(x: x, ignoreElement: ignoreElement, low: low, high: index(before: mid))
    }
    else {
      return mid
    }
  }
}

var array = ["at", "", "", "", "ball", "", "", "car", "", "dad", "", "", ""]
assert(array.sparseSearchFor(x: "dad", ignoreElement: "") == array.index(of: "dad"))

