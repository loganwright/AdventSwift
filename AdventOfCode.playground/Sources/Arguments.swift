import Foundation

func loadFile(name: String) -> String {
    let bundlePath = NSBundle.mainBundle().bundlePath
    guard let url = NSURL(string: bundlePath) else { fatalError() }
    let path = url.URLByAppendingPathComponent(name)
    do {
        return try String(contentsOfFile: path.absoluteString)
    } catch {
        fatalError("\(error)")
    }
}

public let DayOneArgument = loadFile("DayOneArgument.txt")
public let DayTwoArgument = loadFile("DayTwoArgument.txt")
public let DayThreeArgument = loadFile("DayThreeArgument.txt")
public let DayFourArgument = "yzbqklnj"
