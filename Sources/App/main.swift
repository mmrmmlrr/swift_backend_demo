import Vapor
import VaporPostgreSQL
import Foundation
import HTTP
#if os(Linux)
    import Glibc
#endif


let drop = Droplet()
drop.client = FoundationClient.self
drop.preparations.append(Friend.self)
drop.preparations.append(Survey.self)

do {
    try drop.addProvider(VaporPostgreSQL.Provider.self)
} catch {
    assertionFailure("Error adding provider: \(error)")
}


drop.get("friends") { req in
    let friends = try Friend.all().makeNode()
    let friendsDictionoary = ["friends": friends]
    return try JSON(node: friends)
}

drop.get("surveys.json") { req in
    var responseArray = [Survey]()
    
    if let params = req.parameters["debug_parameters"]?.object {
        if let count = params["count"]?.int {
            for _ in 0..<count {
                responseArray.append(Survey.random())
            }
        }

        if let error = params["error"] as? NSError {
            return try JSON(node: [
                "error": true,
                "message": "Something went wrong.",
                "code": 500
                ])
        }
    }

    return try JSON(node: responseArray)
}

drop.post("friend") { req in
    var friend = try Friend(node: req.json)
    try friend.save()
    
    return try friend.makeJSON()
}

drop.resource("posts", PostController())

drop.run()
