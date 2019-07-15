import Foundation

/*:
 16.20 On old cell phones, users typed on a numeric keypad and the phone would provide a list of words that matched these numbers. Each digit mapped to a set of 0—4 letters. Implement an algorithm to return a list of matching words, given a sequence of digits. You are provided a list of valid words (provided in whatever data strucutre you'd like). 
 */

let path = "/usr/share/dict/words"
let url = URL(fileURLWithPath: path, isDirectory: false)
let dictString = try! String(contentsOf: url, encoding: .utf8)
let words = dictString.components(separatedBy: "\n").compactMap { word -> String? in
    let nonLetter = word.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil
    return nonLetter ? nil : word.lowercased()
}

let digitsToChars: [Character: String] = ["2": "abc", "3": "def", "4": "ghi", "5": "jkl", "6": "mno", "7": "pqrs", "8": "tuv", "9": "wxyz"]

let charToDigit: [Character: Character] = {
    digitsToChars.reduce(into: [Character: Character]()) { map, digitChars in
        for char in digitChars.value {
            map[char] = digitChars.key
        }
    }
}()

func digits(from: String) -> String {
    return from.reduce(into: "") { digits, chars in
        if let char = charToDigit[chars] {
            digits.append(char)
        }
    }
}

let digitsToWords = Dictionary(grouping: words, by: digits)

let swift = digitsToWords["79438"]?[0]
assert(swift == "swift", "\(String(describing: swift))")
