//: [Previous](@previous)

import Foundation

let DisallowedSegments = ["ab", "cd", "pq","xy"]
let Vowels = "aeiou" + "AEIOU"
let RequiredVowelsCount = 3

protocol NaughtyOrNiceType {
    var isNice: Bool { get }
}

extension String : NaughtyOrNiceType {
    var isNice: Bool {
        guard !containsAny(DisallowedSegments) else { return false }
        guard hasAtLeastThreeVowels else { return false }
        guard hasConsecutiveCharacters() else { return false }
        return true
    }
    
    func containsAny(subStrings: [String]) -> Bool {
        for subString in subStrings where containsString(subString) {
            return true
        }
        return false
    }
    
    var hasAtLeastThreeVowels: Bool {
        return characters
            .filter { $0.isVowel }
            .count >= RequiredVowelsCount
    }
    
    func hasConsecutiveCharacters(requiredLength: Int = 2) -> Bool {
        var queue: [Character] = []
        for char in characters {
            if queue.contains(char) {
                queue.append(char)
                if queue.count >= requiredLength {
                    return true
                }
            } else {
                queue = [char]
            }
        }
        return false
    }
}

extension Character {
    var isVowel: Bool {
        return Vowels.characters.contains(self)
    }
}

extension Array where Element : NaughtyOrNiceType {
    var numberOfNiceType: Int {
        return self
            .filter { $0.isNice }
            .count
    }
}

DayFiveArgument.componentsSeparatedByString("\n").numberOfNiceType

//: [Next](@next)
