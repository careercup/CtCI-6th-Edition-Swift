import UIKit
/*:
 ## Chapter 1
 *Question 1.1*
 */
//: Using a dictionary.
func isUniqueChars(string: String) -> Bool {
    if string.characters.count > 128 {
        return false
    }
    var charFlags = [String : Bool]()
    for item in string.characters.enumerate() {
        if (charFlags[(String(item.element))] != nil) {
            return false
        }
        charFlags[(String(item.element))] = true
    }
    return true
}
//: Using the unicode scalar representation, because these unicode scalars represent ASCII characters.
func isUniqueChars1(string: String) -> Bool {
    if string.characters.count > 128 {
        return false
    }
    var characterFlags = [Bool](count:128, repeatedValue:false)
    
    for scalar in string.unicodeScalars {
        let value = scalar.value
        let intValue = Int(value)
        if characterFlags[intValue] {
            return false
        }
        characterFlags[intValue] = true
    }
    return true
}

//: Lets see if this works. Uncomment the following code to test this methods.
//let strings = ["abcde", "hello", "apple", "kite", "padle"]
//for string in strings {
//    Swift.print("\(string): \(isUniqueChars(string)) \(isUniqueChars1(string))")
//    var result =
//        isUniqueChars(string)
//    var result1 = isUniqueChars1(string)
//}

//:Question 1.2
//: Solution #1: Sort the strings.
func sort(string: String) -> String {
    let content = [Character](string.characters)
    return String(content.sort(){$0 < $1})
}

func permutation(string1: String, string2: String) -> Bool {
    if string1.characters.count != string2.characters.count {
        return false
    }
    return sort(string1) == sort(string2)
}

var stringPairs = [("dog", "god"), ("abc", "bac")]

for pair in stringPairs {
    permutation(pair.0, string2: pair.1)
}

//: Solution #2: Sort the strings.


