//: [Previous](@previous)

import Foundation

typealias LightGridType = [[Light]]

protocol LightType {
    mutating func turnOn()
    mutating func turnOff()
    mutating func toggle()
}

enum Light : LightType {
    case On
    case Off
    
    mutating func turnOn() {
        self = .On
    }
    
    mutating func turnOff() {
        self = .Off
    }
    
    mutating func toggle() {
        switch self {
        case .On:
            self = .Off
        case .Off:
            self = .On
        }
    }
}

enum Action : String {
    case TurnOn = "turn on"
    case TurnOff = "turn off"
    case Toggle = "toggle"
    
    static var allCases: [Action] {
        return [.TurnOn, .TurnOff, .Toggle]
    }
}

extension LightType {
    mutating func handleAction(action: Action) {
        switch action {
        case .TurnOn:
            self.turnOn()
        case .TurnOff:
            self.turnOff()
        case .Toggle:
            self.toggle()
        }
    }
}

struct LightCoordinate {
    let x: Int, y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

extension LightCoordinate {
    init?(string: String) {
        let components = string
            .componentsSeparatedByString(",")
            .flatMap { Int($0) }
        guard components.count == 2 else { return nil }
        x = components[0]
        y = components[1]
    }
}

struct LightRange {
    let topLeft: LightCoordinate
    let bottomRight: LightCoordinate
}

extension LightRange {
    init(left: LightCoordinate, right: LightCoordinate) {
        let minX = min(left.x, right.x)
        let minY = min(left.y, right.y)
        let maxX = max(left.x, right.x)
        let maxY = max(left.y, right.y)
        
        topLeft = LightCoordinate(x: minX, y: minY)
        bottomRight = LightCoordinate(x: maxX, y: maxY)
    }
}


extension LightRange {
    var xRange: Range<Int> {
        return topLeft.x...bottomRight.x
    }
    var yRange: Range<Int> {
        return topLeft.y...bottomRight.y
    }
    
    var allCoordinates: [LightCoordinate] {
        let xRange = topLeft.x...bottomRight.x
        let yRange = topLeft.y...bottomRight.y
        
        return xRange.flatMap { x in
            return yRange.map { y in
                return LightCoordinate(x: x, y: y)
            }
        }
    }
}

struct Command {
    let action: Action
    let range: LightRange
}

extension String {
    func loadCommands() -> [Command] {
        return self
            .componentsSeparatedByString("\n")
            .flatMap { $0.command }
    }
    
    var command: Command? {
        guard let action = action else { return nil }
        guard
            let lightCoordinates = lightCoordinates
            where lightCoordinates.count == 2
            else { return nil }
    
        let lightRange = LightRange(left: lightCoordinates[0], right: lightCoordinates[1])
        return Command(action: action, range: lightRange)
    }
    
    var action: Action? {
        return Action.allCases
            .lazy
            .filter({ self.hasPrefix($0.rawValue) })
            .first
    }
 
    var lightCoordinates: [LightCoordinate]? {
        return self.componentsSeparatedByString(" ")
            .filter { !$0.isEmpty }
            .filter { $0 != "through" }
            .flatMap { LightCoordinate(string: $0) }
    }
}


let LightRow = [Light].init(count: 1000, repeatedValue: .Off)
let LightGrid = [[Light]].init(count: 1000, repeatedValue: LightRow)

func lightsOnAfterInstructions(instructions: String, lightGrid: LightGridType = LightGrid) -> Int {
    var grid = lightGrid
    
    instructions
        .componentsSeparatedByString("\n")
        .flatMap { $0.command }
        .forEach { command in
            let range = command.range
            range.xRange.forEach { x in
                range.yRange.forEach { y in
                    grid[y][x].handleAction(command.action)
                }
            }
        }

    return grid
        .flatten()
        .filter { $0 == .On }
        .count
}

lightsOnAfterInstructions(DaySixArgument)

//: [Next](@next)
