//: [Previous](@previous)

// MARK: Day Two

typealias Feet = Int
typealias SquareFeet = Int

protocol WrappableType {
    func amountOfWrappingPaperRequired() -> SquareFeet
}

struct Box {
    
    let width: Feet
    let height: Feet
    let length: Feet
    
    let top: SquareFeet
    let front: SquareFeet
    let side: SquareFeet
    
    var area: SquareFeet {
        return [top, front, side]
            .map { $0 * 2 }
            .reduce(0, combine: +)
    }
    
    init(string: String) {
        let boxValues = string
            .componentsSeparatedByString("x")
            .flatMap { Int($0) }
        assert(boxValues.count == 3, "THING: \(string)")
        width = boxValues[0]
        height = boxValues[1]
        length = boxValues[2]
        
        top = width * length
        front = width * height
        side = height * length
    }
}

extension Box : WrappableType {
    func amountOfWrappingPaperRequired() -> SquareFeet {
        let smallestSide = min(top, front, side)
        return smallestSide + area
    }
}

extension Array where Element : WrappableType {
    func amountOfWrappingPaperRequired() -> SquareFeet {
        return self
            .map { $0.amountOfWrappingPaperRequired() }
            .reduce(0, combine: +)
    }
}

extension String {
    func loadBoxes() -> [Box] {
        return self
            .componentsSeparatedByString("\n")
            .filter { !$0.isEmpty }
            .map(Box.init)
    }
}

DayTwoArgument.loadBoxes().amountOfWrappingPaperRequired()

//: [Next](@next)
