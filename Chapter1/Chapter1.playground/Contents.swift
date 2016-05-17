import UIKit
/*:
 ## Chapter 1
 **Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
 
 **Question 1.1**
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

//: Uncomment the following code to test this methods:
//let strings = ["abcde", "hello", "apple", "kite", "padle"]
//for string in strings {
//    Swift.print("\(string): \(isUniqueChars(string)) \(isUniqueChars1(string))")
//    var result =
//        isUniqueChars(string)
//    var result1 = isUniqueChars1(string)
//}
/*:
 **Question 1.2**
 
 Solution #1:
 */
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
//: Solution #2:
func permutation2(string1: String, string2: String) -> Bool {
    if string1.characters.count != string2.characters.count {
        return false
    }
    
    var letters = [Int](count:128, repeatedValue: 0)
    
    for scalar in string1.unicodeScalars {
        let value = scalar.value
        let intValue = Int(value)
        letters[intValue] += 1
    }
    
    for scalar in string2.unicodeScalars {
        let value = scalar.value
        let intValue = Int(value)
        letters[intValue] -= 1
        if letters[intValue] < 0 {
            return false
        }
    }
    return true
}

//: Uncomment the following code to test this methods.
var stringPairs = [("dog", "god"), ("abc", "bac"), ("xyz", "yyz")]

for pair in stringPairs {
    permutation(pair.0, string2: pair.1)
    permutation(pair.0, string2: pair.1)
}



