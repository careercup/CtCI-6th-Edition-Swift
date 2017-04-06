import Foundation

/*:
 16.9 Implement subtract, multiply, and divide using only +
 */
extension Integer where Stride: SignedInteger {
    
    func restrictedDivide(x: Self) -> Self {
        var _self = self.absv
        let absX = x.absv
        let diff = absX.negate()
        var quotient: Self = 0
        
        while _self >= absX {
            _self += diff
            quotient = quotient.advanced(by: 1)
        }
        let sameSign = (self < 0 && x < 0) || (self > 0 && x > 0)
        return sameSign ? quotient : quotient.negate()
    }
    
    func restrictedMultiply(x: Self) -> Self {
        let absX: Self = x.absv
        var _self: Self = 0
        for _ in 0..<absX {
            _self += self
        }
        return x < 0 ? _self.negate() : _self
    }
    
    func restrictedSubtract(x: Self) -> Self {
        return self + x.negate()
    }
    
    func negate() -> Self {
        let diff: Self = self > 0 ? -1 : 1
        var _self = self
        var result: Self = 0
        while _self != 0 {
            _self += diff
            result += diff
        }
        return result
    }
    
    func restrictedSubtract2(x: Self) -> Self {
        return self + ~x + 1
    }
}

var a = 35
var b = 7

for x in a...2 * a {
    assert(x.restrictedDivide(x: b) == x / b)
    assert(x.restrictedMultiply(x: b) == x * b)
    assert(x.restrictedSubtract(x: b) == x - b)
}



