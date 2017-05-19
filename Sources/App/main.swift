import Vapor
import VaporPostgreSQL
import Foundation
import HTTP

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

drop.get("surveys") { req in
    
    let surveys = [Survey(title: "Hotel Red Planet")]
    let friendsDictionoary = ["surveys": surveys]
    return try JSON(node: surveys)
}

drop.post("friend") { req in
    var friend = try Friend(node: req.json)
    try friend.save()
    
    return try friend.makeJSON()
}

drop.resource("posts", PostController())

drop.run()
