import FluentProvider

public final class Answer: Model, Timestampable {

    public let storage = Storage()
    
    public var questionId: String
    public var text: String

    public init(row: Row) throws {
        self.questionId = try row.get("question_id")
        self.text = try row.get("text")
    }

    public init(questionId: String, text: String) {
        self.questionId = questionId
        self.text = text
    }

    public func makeRow() throws -> Row {
        var row = Row()
        try row.set("question_id", self.questionId)
        try row.set("text", self.text)
        return row
    }
}

extension Answer: NodeRepresentable {
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "question_id": self.questionId,
            "text": self.text
        ])
    }
}

extension Answer: Preparation {
    public static func prepare(_ database: Database) throws {
        try database.create(self) {
            $0.id()
            $0.string("question_id")
            $0.string("text")
        }
        try database.index("question_id", for: Answer.self)
    }
    
    public static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}