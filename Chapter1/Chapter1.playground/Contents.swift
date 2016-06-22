import UIKit
/*:
 ## Chapter 1
 **Note:** If you're seeing this text as comments rather than nicely-rendered text, select Editor\Show Rendered Markup in the Xcode menu.
 
  **Question 1.1**
 
 Using a dictionary.
 */
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
        Swift.print(item.element)
    }
    return true
}
//: Using the unicode scalar representation since these unicode scalars represent ASCII characters.
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


let strings = ["abcde", "hello", "apple", "kite", "padle"]
for string in strings {
    Swift.print("\(string): \(isUniqueChars(string)) \(isUniqueChars1(string))")
    var result =
        isUniqueChars(string)
    var result1 = isUniqueChars1(string)
}
/*:
 **Question 1.2**
 
 Solution #1: sorting.
 */
func permutation(string1: String, string2: String) -> Bool {
    if string1.characters.count != string2.characters.count {
        return false
    }
    return sort(string1) == sort(string2)
}

func sort(string: String) -> String {
    let content = [Character](string.characters)
    return String(content.sort(){$0 < $1})
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
        Swift.print("\(value)")
        letters[intValue] -= 1
        if letters[intValue] < 0 {
            return false
        }
    }
    return true
}

//: Lets test both solutions:


let stringPairs = [("dog", "god"), ("abc", "bac"), ("xyz", "yyz")]

for pair in stringPairs {
    permutation(pair.0, string2: pair.1)
    permutation2(pair.0, string2: pair.1)
}

/*:
 
 **Question 1.6**
 */
func compress(string: String) -> String {
    var compressedString = String()
    var countConsecutive = 0
    var counter = 0
    for char in string.characters.indices {
        countConsecutive += 1
        counter += 1
        if counter >= string.characters.count || string[char] != string[char.successor()] {
            compressedString += "\(string[char])" + "\(countConsecutive)"
            countConsecutive = 0
        }
    }
    return compressedString.characters.count < string.characters.count ? compressedString : string
}

//: Lets test it:

var example = "aabbcccca"
var result = compress(example)

/*:
 
 **Question 1.7**
 */

func rotate(inout matrix:[[Int]]) {
    for layer in 0..<(matrix.count/2) {
        let first = layer
        let last = matrix.count - 1 - layer
        for i in first..<last {
            let offset = i - first
            // save the top.
            let top = matrix[first][i]
            matrix[first][i] = matrix[last - offset][first]
            matrix[last - offset][first] = matrix[last][last-offset]
            matrix[last][last - offset] = matrix[i][last]
            matrix[i][last] = top
        }
    }
}

func printMatrix(matrix: [[Int]]) {
    for row in 0..<matrix.count {
        for column in 0..<matrix[row].count {
            Swift.print(matrix[row][column], terminator: "  ")
        }
        Swift.print("")
    }
}

//: Lets test it:

var matrix =                     [[1,3,6,9],
                                  [2,4,5,6],
                                  [3,6,9,12],
                                  [4,8,16,24]]


rotate(&matrix)
printMatrix(matrix)

/*:
 
 **Question 1.7**
 */

func setZeros(inout matrix: [[Int]]) {
    var rowHasZero = false
    var columnHasZero = false
    
    //:Check if the first row has a zero.
    for j in 0..<matrix[0].count {
        if matrix[0][j] == 0 {
            rowHasZero = true
            break
        }
    }
    
    //:Check if first column has a zero.
    for i in 0..<matrix.count {
        if matrix[i][0] == 0 {
            columnHasZero = true
            break
        }
    }
    
    //:Check for zeros in the rest of the array.
    for i in 1..<matrix.count {
        for j in 1..<matrix.count {
            if matrix[i][j] == 0 {
                matrix[i][0] = 0
                matrix[0][j] = 0
            }
        }
    }
    
    //:Nullify rows based on values in first column.

    
    func nullifyRow(inout matrix:[[Int]], row: Int) {
        for j in 0..<matrix[0].count {
            matrix[row][j] = 0
        }
    }
    
    for i in 1..<matrix.count {
        if matrix[i][0] == 0 {
            nullifyRow(&matrix, row: i)
        }
    }
    
    //: Nullify columns based on values in first row.
    
    func nullifyColumn(inout matrix:[[Int]], column: Int) {
        for i in 0..<matrix.count {
            matrix[i][column] = 0
        }
    }
    
    for j in 1..<matrix[0].count {
        if matrix[0][j] == 0 {
            nullifyColumn(&matrix, column: j)
        }
    }
    
    //: Nullify first row.
    if rowHasZero {
        nullifyRow(&matrix, row: 0)
    }
    //: Nullify first column.
    if columnHasZero {
        nullifyColumn(&matrix, column: 0)
    }
}

//: Lets test it:
var testMatrix = [[1,0,1,1],
                  [1,1,1,1],
                  [1,0,1,1],
                  [1,0,1,1]]

setZeros(&testMatrix)
printMatrix(testMatrix)


