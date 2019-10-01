import Foundation

//: 16.2  Design a method to find the frequency of occurrences of any given word in a book. What if we were running this algorithm multiple times?
extension String {
    func separateWords() -> [String] {
        return lowercased().split(whereSeparator: { $0 == " " || $0 == "," || $0 == "." }).map(String.init)
    }
}

func precomputeCache(_ text: String) -> [String : Int] {
    var cache: [String : Int] = [:]
    
    let words = text.separateWords()
    words.forEach {
        let value = (cache[$0] ?? 0) + 1
        cache[$0] = value
    }
    
    return cache
}

func wordFrequencies(_ word: String, withCache cache: [String : Int]) -> Int {
    return cache[word.lowercased()] ?? 0
}

let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sapien purus, dapibus vel tincidunt et, gravida at nunc. Nullam pretium at urna ut molestie. Duis ipsum magna, blandit vitae turpis ut, tincidunt elementum nunc. Morbi interdum sapien sit amet vestibulum lobortis. Nulla nec ex in urna auctor volutpat vitae vel ligula. Cras sodales tellus eget urna pulvinar, ac iaculis velit tempor. Nullam ornare arcu ut elit tincidunt, quis facilisis tortor volutpat. Mauris in libero lacinia, pellentesque nulla id, consequat ante. Proin non porta nunc. Cras pretium risus sit amet tellus posuere malesuada. Donec egestas magna dui, aliquet hendrerit nisl porttitor a. Proin in posuere est. Proin risus metus, mollis id tempus id, iaculis at neque. Aenean eget sem arcu. Nam vehicula scelerisque porttitor."
let cache = precomputeCache(text)

let words = text.separateWords()
for i in 0..<5 {
    let frequency = wordFrequencies(words[i], withCache: cache)
    print("Frequency of word \(words[i]): \(frequency)")
}
