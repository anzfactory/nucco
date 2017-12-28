import Vapor
import HTTP

final class IndexController: BaseController {
    
    func index(_ req: Request) throws -> ResponseRepresentable {
        return try view.make("Index/index", [
            "title": "ようこそ！"
        ], for: req)
    }
}
