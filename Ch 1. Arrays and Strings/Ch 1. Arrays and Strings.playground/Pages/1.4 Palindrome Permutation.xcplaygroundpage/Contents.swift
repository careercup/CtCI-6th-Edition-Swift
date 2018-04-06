//: 1.4 Check if a string is a permutation of a palindrome

extension String {

    func isPalindromePermutation() -> Bool {
        var charactersSet = Set<Character>()
        for ch in self {
            if charactersSet.contains(ch) {
                charactersSet.remove(ch)
            }
            else {
                charactersSet.insert(ch)
            }
        }

        var isPalindrom = false
        if self.count % 2 == 1 && charactersSet.count == 1 {
            isPalindrom = true
        }
        else if charactersSet.isEmpty == true {
            isPalindrom = true
        }

        return isPalindrom
    }

}

"abcrcab".isPalindromePermutation()
"abccab".isPalindromePermutation()
"bcrcab".isPalindromePermutation()
