import Foundation

/*:
 Given and Int, find the length of the longest sequence of ones you could create by flipping one bit from 0 to 1
 
 Example:
 
 Input: `1775 (11011101111)`
 
 Output: `8`
 
 */

extension Int {
    
    var lengthOfLongest1sByFlippingABitFrom0To1: Int {
        guard self != -1 else { return  64 }
        var previousCount = 0
        var currentCount = 0
        var maxLength = 0
        for i in 0..<64 {
            let mask = 1 << i
            let bitIs1 = self & mask == mask
            if bitIs1 {
                currentCount += 1
            }
            else {
                if currentCount + previousCount + 1 > maxLength {
                    maxLength = currentCount + previousCount + 1
                }
                guard i + 1 < 64 else { break }
                let nextBitMask = 1 << (i + 1)
                let nextBitIs1 = self & nextBitMask == nextBitMask
                if nextBitIs1 {
                    previousCount = currentCount
                    currentCount = 0
                }
                else {
                    currentCount = 0
                    previousCount = 0
                }
            }
        }
        if currentCount + previousCount + 1 > maxLength {
            maxLength = currentCount + previousCount + 1
        }
        return maxLength
    }
}

let testCases = [-1: 64, Int.max: 64, -10: 63, 0: 1, 1: 2, 15: 5, 1775: 8]
testCases.forEach { e in
    assert(e.0.lengthOfLongest1sByFlippingABitFrom0To1 == e.1, "\(e.0.lengthOfLongest1sByFlippingABitFrom0To1) != \(e.1)")
}

