import Foundation

let path = "/usr/share/dict/words"
let url = URL(string: "file://" + path)!
let words = try! String(contentsOf: url, encoding: .utf8).components(separatedBy: "\n").flatMap { s -> String? in
    let ignore = s.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil
    return ignore ? nil : s.lowercased()
}

let digitsToChars: [Character: String] = ["2": "abc", "3": "def", "4": "ghi", "5": "jkl", "6": "mno", "7": "pqrs", "8": "tuv", "9": "wxyz"]

let charToDigit: [Character: Character] = {
    var map = [Character: Character]()
    for (digit, chars) in digitsToChars {
        for c in chars.characters {
            map[c] = digit
        }
    }
    return map
}()

func digits(from: String) -> String {
    let chars = from.characters.flatMap {
        charToDigit[$0]
    }
    return String(chars)
}

let digitsToWords = words.groupBy(key: digits)


print(digitsToWords["79438"])
