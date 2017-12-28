import Vapor
import HTTP

final class QuestionController: BaseController {

    func index(_ req: Request) throws -> ResponseRepresentable {
        
        if let question = self.user.findRandomQuestion() {
            return try view.make("Question/index", [
                "question": question,
                "count": self.user.countQuestion()
            ], for: req)
        } else {
            throw Abort(.notFound)
        }
        
    }

    func answers(_ req: Request) throws -> ResponseRepresentable {
        let id: String = try req.parameters.next(String.self)
        let question: Question
        do {
            question = try self.user.getQuestion(id: id)
        } catch {
            throw Abort(.notFound)
        }

        let answers = try question.answers.all()

        return try view.make("Question/answers", [
            "question": question,
            "answers": answers
        ])
    }

    func answer(_ req: Request) throws -> ResponseRepresentable {
        
        let id: String = try req.parameters.next(String.self)
        let question: Question
        do {
            question = try self.user.getQuestion(id: id)
        } catch {
            throw Abort(.notFound)
        }

        // validate
        // validatorつくりたさ😇
        if let text = req.data["answer"]?.string, !text.isEmpty {
            let answer = try self.user.saveAnswer(question.id!.string!, answer: text)
            return try view.make("Question/answer", [
                "question": question,
                "answer": answer
            ], for: req)
        } else {
            // Flash Message的なのつくりたさ...😇
            return try view.make("error", [
                "message": "回答を入力してください！"
            ], for: req)
        }
        
    }

    func create(_ req: Request) throws -> ResponseRepresentable {
        
        var params: [String: Any] = [:]
        // 登録処理
        if let text = req.data["question"]?.string, !text.isEmpty {
            let question = try self.user.saveQuestion(text)
            params["question"] = question
        } else {
            params["errorMessage"] = "質問を入力！！"
        }

        return try view.make("Question/create", params, for: req)
    }
}
