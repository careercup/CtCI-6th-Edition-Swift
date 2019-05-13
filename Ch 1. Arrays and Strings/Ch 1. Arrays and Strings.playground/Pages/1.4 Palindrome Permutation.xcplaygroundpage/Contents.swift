//: 1.4 Check if a string is a permutation of a palindrome
import Foundation

extension String {
    
    func isPalindromePermutation() -> Bool {
        let charCounts = characterCounts()
        let charsWithOddCount = charCounts.filter { e in
            e.value % 2 != 0
        }
        return charsWithOddCount.count <= 1
    }
}

extension String {
    
    func characterCounts() -> [Character: Int] {
        let punctuation = NSMutableCharacterSet.punctuation()
        punctuation.formUnion(with: NSCharacterSet.whitespaces)
        return reduce(into: [Character: Int]()) { map, char in
            let lower = char.lowercased()
            guard let codeUnit = lower.utf16.first else { return }
            if !punctuation.characterIsMember(codeUnit) {
                map[Character(lower), default: 0] += 1
            }
        }
    }

}

var s1 = "A man, a plan, a canal – Panama"
let s2 = String(s1.shuffled())
assert(s2.isPalindromePermutation(), s2)


