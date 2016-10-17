import Foundation


// 1.3 Replace all spaces in a string with %20

extension String {
    
    func urlIfy() -> String {
        var s = ""
        for c in characters {
            s += c == " " ? "%20" : String(c)
        }
        return s
    }
    
    mutating func urlIfyInPlace() {
        var replacements = 0
        withMutableCharacters { cv in
            for i in cv.indices where cv[i] == " " {
                cv.replaceSubrange(i...i, with: "%".characters)
                let next = cv.index(after: i)
                cv.insert(contentsOf: "20".characters, at: next)
                replacements += 1
            }
            cv = cv.dropLast(replacements * 2)
        }
    }
}


var s = "mr john smith    "
let count = s.characters.count
s.urlIfyInPlace()
print("\"\(s)\"")
assert(count == s.characters.count)
assert(s == "mr%20john%20smith")


