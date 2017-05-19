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

drop.get("surveys.json") { req in
    
    let surveys: [Survey] = [Survey(title: "Red Planet",
                                    coverImageUrl: "http://dreamatico.com/data_images/hotels/hotels-3.jpg",
                                    description: "Asoke, Bangkok",
                                    id: Node.string(NSUUID().uuidString)),
                             Survey(title: "Hilton",
                                    coverImageUrl: "http://dreamatico.com/data_images/hotels/hotels-2.jpg",
                                    description: "Sukhumvit, Bangkok",
                                    id: Node.string(NSUUID().uuidString)),
    ]
    
    return try JSON(node: surveys)
}

drop.post("friend") { req in
    var friend = try Friend(node: req.json)
    try friend.save()
    
    return try friend.makeJSON()
}

drop.resource("posts", PostController())

drop.run()
