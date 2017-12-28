import Vapor
import HTTP

class BaseController {

    let user: User

    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.user = Anonymous()
        self.view = view
    }
}