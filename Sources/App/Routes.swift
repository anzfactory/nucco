import Vapor

final class Routes: RouteCollection {
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }

    func build(_ builder: RouteBuilder) throws {
        builder.get("") { req in 
            return try IndexController(self.view).index(req)
        }

        // 固定のactionでいいならこの指定もできる
        // 利用できるactionとpathはここ https://docs.vapor.codes/2.0/vapor/controllers/#actions
        // builder.resource("question", QuestionController(view))
        builder.group("q") {
            let vc = QuestionController(self.view)
            
            $0.get(String.parameter, "answers", handler: vc.answers)
            $0.post(String.parameter, "answer", handler:vc.answer)
            
            $0.post("create", handler: vc.create)
            
            $0.get("", handler: vc.index)
        }
        
        // response to requests to /info domain
        // with a description of the request
        builder.get("info") { req in
            return req.description
        }

    }
}
