import Foundation

/*:
 1.9 Write a function to determine if one string is a rotation of the other, using only 
 1 call to a stdlib substring function
 */

extension String {
    
    func isRotation(of other: String) -> Bool {
        return (self + self).contains(other)
    }
}

let a = ""
" ".isRotation(of: "")
assert("etcart".isRotation(of: "cartet"))
assert("cartet".isRotation(of: "etcart"))
assert("waterbottle".isRotation(of: "erbottlewat"))
