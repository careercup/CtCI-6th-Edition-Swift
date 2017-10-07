import Foundation

/*:
 8.5 Write a recursive function to multiply two positive integers without using the * operator. You can use addition, subtraction, and bit shifting, but you should minimize the number of those operations.
 */

extension FixedWidthInteger {
  
  func multiplyWithoutUsingStar(x: Self) -> Self {
    var x = x
    var product = self
    while x > 1 {
      product += self
      x = x.advanced(by: -1)
    }
    return product
  }
  
  func multiplyWithoutUsingStarRecursive(x: Self) -> Self {
    return multiplyWithoutUsingStarRecursive(product: self, x: x)
  }
  
  private func multiplyWithoutUsingStarRecursive(product: Self, x: Self) -> Self {
    guard x > 1 else { return product }
    var product = product
    product += self
    var x = x
    x = x.advanced(by: -1)
    return multiplyWithoutUsingStarRecursive(product: product, x: x)
  }
}

assert(723.multiplyWithoutUsingStar(x: 456) == 723 * 456)
assert(723.multiplyWithoutUsingStarRecursive(x: 456) == 723 * 456)

