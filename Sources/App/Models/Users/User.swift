// MARK: - User
protocol User {
    var name: String { get }

    // MARK: Question
    func getQuestion(id: String) throws -> Question
    func countQuestion() -> Int
    func findRandomQuestion() -> Question?
    func saveQuestion(_ text: String) throws -> Question
    // MARK: Answer
    func saveAnswer(_ questionId: String, answer: String) throws -> Answer
}

// MARK: - Question
extension User {
    func getQuestion(id: String) throws -> Question {
        if let question = try Question.find(id) {
            return question
        } else {
            throw QuestionError.notFound
        }
    }
    func countQuestion() -> Int {
        do {
            return try Question.count()
        } catch {
            print(error)
            return 0
        }
    }
    func findRandomQuestion() -> Question? {
        do {
            let count = try Question.count()
            
            if count == 0 {
                return nil
            }

            let results = try Question.database?.raw("SELECT * FROM questions OFFSET floor(random() * \(count)) LIMIT 1;")
            if let item = results?.array?[0] {
                return try Question(node: item)
            } else {
                return nil
            }
            
        } catch {
            print(error)
            return nil
        }
    }
    func saveQuestion(_ text: String) throws -> Question {
        let question = Question(name: self.name, text: text)
        try question.save()
        return question
    }
}

// MARK: - User
extension User {
    func saveAnswer(_ questionId: String, answer: String) throws -> Answer {
        let answer = Answer(questionId: questionId, text: answer)
        try answer.save()
        return answer
    }
}
