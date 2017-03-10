import Foundation

/*:
 8.9 Implement an algorithm to print all valid (e.g. properly opened and closed) combinations of n parenthesis. 
 */

func combinationsOfPairsOfParentheses(count: Int) -> Set<String> {
  var allCombintations = Set(["()"])
  var level = 0
  for _ in 1..<count {
    var combinations = Set<String>()
    for s in allCombintations {
      s.characters.indices.forEach { i in
        level += s[i] == "(" ? 1 : -1
        if level > 0 {
          var s = s
          s.insert(contentsOf: ["(", ")"], at: s.characters.index(after: i))
          combinations.insert(s)
        }
      }
      combinations.insert("()" + s)
    }
    allCombintations = combinations
  }
  return allCombintations
}

var p = Array(combinationsOfPairsOfParentheses(count: 3)).sorted()
assert(p == ["((()))", "(()())", "(())()", "()(())", "()()()"])
