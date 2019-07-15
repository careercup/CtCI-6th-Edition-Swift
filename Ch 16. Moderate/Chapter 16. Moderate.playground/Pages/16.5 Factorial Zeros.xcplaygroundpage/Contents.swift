import Foundation

/*:
 16.5 Count the number of trailing zeros in n factorial
 */

extension Int {
    
    func zerosInFactorial() -> Int {
        guard self > 0 else { return 0 }
        let range = (1...self)
        return range.reduce(0) {
            $1 % 5 == 0 ? $0 + 1 : $0
        }
    }
    
    func factorial() -> Int {
        guard self > 0 else { return 1 }
        let range = (1...self)
        return range.reduce(1, *)
    }
}

for i in 1...20 {
    let s = String(i.factorial())
    let trailingZerosString = s.reversed().prefix(while: { $0 == "0" })
    let zerosInFactorial = i.zerosInFactorial()
    assert(zerosInFactorial == trailingZerosString.count, "\(i) \(zerosInFactorial) \(trailingZerosString)")
}
