
// MARK: Day One

typealias Floor = Int

extension Floor {
    init?(instruction: Character) {
        switch instruction {
        case "(":
            self = 1
        case ")":
            self = -1
        default:
            return nil
        }
    }
}

func findFloor(instructions: String) -> Floor {
    return instructions
        .characters
        .flatMap(Floor.init)
        .reduce(0, combine: +)
}

findFloor(DayOneArgument)

//: [Next](@next)
