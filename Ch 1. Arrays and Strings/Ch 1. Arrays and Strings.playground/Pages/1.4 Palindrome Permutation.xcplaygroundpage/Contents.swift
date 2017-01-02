//: 1.4 Check if a string is a permutation of a palindrome

extension String {
    
    func isPalindromePermutation(of: String) -> Bool {
        let counts1 = characterCounts()
        let isPalindrome = counts1.filter { e in
            e.value % 2 != 0
        }
        let counts2 = of.characterCounts()
        return isPalindrome.count <= 1 && counts2 == counts1
    }
}

extension String {
    
    func characterCounts() -> [Character: Int] {
        var characterCounts = [Character: Int]()
        characters.forEach { c in
            characterCounts[c] = (characterCounts[c] ?? 0) + 1
        }
        return characterCounts
    }
}

var s1 = "abccba"
var s2 = "abcabc"
assert(s2.isPalindromePermutation(of: s1))


