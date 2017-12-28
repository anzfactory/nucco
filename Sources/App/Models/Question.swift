import FluentProvider
import Fluent

public final class Question: Model, Timestampable {
    
    public let storage = Storage()
    
    public var name: String
    public var text: String

    public init(row: Row) throws {
        self.name = try row.get("name")
        self.text = try row.get("text")
    }

    public init(name: String, text: String) {
        self.name = name
        self.text = text
    }

    public convenience init(node: Node) throws {
        let row = Row(node.wrapped)
        try self.init(row: row)
        self.id = try row.get(self.idKey)
        self.exists = true
    }

    public func makeRow() throws -> Row {
        var row = Row()
        try row.set("id", self.id)
        try row.set("name", self.name)
        try row.set("text", self.text)
        return row
    }
}


// MARK: - Relation
extension Question {
    var answers: Children<Question, Answer> {
        return children()
    }
}

extension Question: NodeRepresentable {
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "id"  : self.id,
            "text": self.text
        ])
    }
}

extension Question: Preparation {
    public static func prepare(_ database: Database) throws {
        try database.create(self) {
            $0.id()
            $0.string("name")
            $0.string("text")
        }
    }
    
    public static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
