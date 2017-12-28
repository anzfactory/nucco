import Foundation
import Leaf

public class Nl2br: BasicTag {
    public let name = "nl2br"
    public func run(arguments: ArgumentList) throws -> Node? {
        guard 
            arguments.count == 1,
            let text = arguments[0]?.string
        else {
            return Node(nil)
        }
        let result = text.components(separatedBy: "\n").reduce("") { (string, line) -> String in
            let result = string + (self.escape(line) + "<br>")
            return result
        }
        return .bytes(result.makeBytes())
    }


    func escape(_ string: String) -> String {
        var newString = string
        let chars = [
            "&amp;" : "&",
            "&lt;" : "<",
            "&gt;" : ">",
            "&quot;" : "\"",
            "&apos;" : "'"
        ];
        for (escapedChar, unescapedChar) in chars {
            newString = newString.replacingOccurrences(of: escapedChar, with: unescapedChar, options: NSString.CompareOptions.literal, range: nil)
        }
        return newString
    }
}
