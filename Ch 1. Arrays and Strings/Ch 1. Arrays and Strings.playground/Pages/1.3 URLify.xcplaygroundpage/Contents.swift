import Foundation


/*:
1.3 Replace all spaces in a string with %20
*/

extension String {
    
    func replaceSpaces(n: Int) -> String {
        let charArray = Array(self)[0...n-1]

        let stringArray = charArray.map { (char) -> String in
            return String(char) == " " ? "%20" : String(char)
        }

        return stringArray.map({$0}).joined()
    }
}

let verify = "mr%20john%20smith"
var string = "mr john smith          "
assert(string.replaceSpaces(n: 13) == verify)



