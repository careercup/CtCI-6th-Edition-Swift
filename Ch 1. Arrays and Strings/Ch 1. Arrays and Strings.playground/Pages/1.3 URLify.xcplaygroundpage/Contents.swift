import Foundation


/*:
1.3 Replace all spaces in a string with %20
*/

extension String {
    
    func urlIfy() -> String {
        var s = ""
        for char in self {
            s += char == " " ? "%20" : String(char)
        }
        return s
    }
    
    mutating func urlIfyInPlace() {
        var replacements = 0
        for i in indices where self[i] == " " {
            replaceSubrange(i...i, with: "%")
            let next = index(after: i)
            insert(contentsOf: "20", at: next)
            replacements += 1
        }
        removeLast(replacements * 2)
    }
}

let verify = "mr%20john%20smith"
var string = "mr john smith"
assert(string.urlIfy() == verify)

string = "mr john smith    "
var copy = string
copy.urlIfyInPlace()
print("\"\(copy)\"")
assert(copy == verify)


