//: [Previous](@previous)

// MARK: Day Three

struct HouseCoordinate : Hashable {
    let x: Int, y: Int
    
    var hashValue: Int {
        return "\(x):\(y)".hashValue
    }
}

extension HouseCoordinate {
    mutating func moveDirection(direction: Direction) -> HouseCoordinate {
        switch direction {
        case .North:
            return HouseCoordinate(x: x, y: y + 1)
        case .East:
            return HouseCoordinate(x: x + 1, y: y)
        case .South:
            return HouseCoordinate(x: x, y: y - 1)
        case .West:
            return HouseCoordinate(x: x - 1, y: y)
        }
    }
}

func ==(lhs: HouseCoordinate, rhs: HouseCoordinate) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

enum Direction : Character {
    case North = "^"
    case East = ">"
    case South = "v"
    case West = "<"
}

func numberOfHousesDeliveredToWithInstructions(instructions: String) -> Int {
    var currentCoordinate = HouseCoordinate(x: 0, y: 0)
    
    // Always start on current coordinate
    var visitedHouses = Set<HouseCoordinate>([currentCoordinate])
    
    instructions
        .characters
        .flatMap(Direction.init)
        .forEach { direction in
            currentCoordinate = currentCoordinate.moveDirection(direction)
            visitedHouses.insert(currentCoordinate)
    }
    
    return visitedHouses.count
}

numberOfHousesDeliveredToWithInstructions(DayThreeArgument)

//: [Next](@next)
