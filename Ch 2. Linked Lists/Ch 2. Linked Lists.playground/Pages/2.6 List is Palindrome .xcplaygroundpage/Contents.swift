import Foundation

/*:
 2.6
 Write a function that returns whether or not a singly linked list is a palindrome
 */

extension List where Element: Equatable {
    
    func isPalindrome() -> Bool {
        let (left, right) = split(at: count / 2)
        if count.isEven {
            return left == right.reversed()
        }
        else {
            return left == right.dropFirst().reversed()
        }
    }
}

let palindromeChars = "tacocat".reduce(into: []) { $0.append($1) }
let listCharacters = List(array: palindromeChars)
assert(listCharacters.isPalindrome())
assert(listCharacters.dropFirst().isPalindrome() == false)

let listInts = List(arrayLiteral: 1,2,3,3,2,1)
assert(listInts.isPalindrome())
assert(listInts.dropLast().isPalindrome() == false)
