//: 1.4 Check if a string is a permutation of a palindrome

extension String {
    
    func isPalindromePermutation() -> Bool {
        let counts = characterCounts()
        let lettersWithOddCount = counts.filter { e in
            e.value % 2 != 0
        }
        return lettersWithOddCount.count <= 1
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

var s1 = "abcabc"
assert(s1.isPalindromePermutation())


