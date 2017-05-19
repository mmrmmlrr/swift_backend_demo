//
//  Survey.swift
//  MyBackend
//
//  Created by Oleksii Chernysh on 5/19/17.
//
//

import Foundation
import Vapor

struct Survey {
    var title = ""
    var coverImageUrl = ""
    var description = ""
    var id: Node? = Node.string(NSUUID().uuidString)
}

extension Survey: Model {
    
    init(node: Node, in context: Context) throws {
        title = try node.extract("title")
        coverImageUrl = try node.extract("cover_image_url")
        description = try node.extract("description")
    }
    
    func makeNode() throws -> Node {
        return try! Node(node: [
            "title": title,
            "cover_image_url": coverImageUrl,
            "description": description,
            "id": id
            ]
        )
    }
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "title": title,
            "cover_image_url": coverImageUrl,
            "description": description,
            "id": id
            ]
        )
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("surveys") { surveys in
            surveys.id()
            surveys.string("title")
            surveys.string("cover_image_url")
            surveys.string("description")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("surveys")
    }
    
}

extension Survey: Randomizable {
    
    static func random() -> Survey {
        return Survey(title: randomTitle(),
                      coverImageUrl: randomImageURL(),
                      description: randomDescription(),
                      id: randomId())
    }
    
}

func randomTitle() -> String {
    return ["Hilton",
            "Mariott",
            "Novotel",
            "Red Planet",
            "Clarion",
            "Bayoke"
        ].randomElement()
}

func randomDescription() -> String {
    return ["Located among Thailand’s highest mountains,",
            "Despite being Thailand's fifth-largest city, Chiang Mai still keeps a relaxed and laidback feel",
            "This reputation is partly due to its proximity",
             "Don’t forget to buy an umbrella from Bo Sang and eat a bowl of kao soi.",
            "Whether you arrive at Chiang Mai International Airport "
        ].randomElement()
}

func randomImageURL() -> String {
    return ["http://dreamatico.com/data_images/hotels/hotels-4.jpg",
            "http://www.gardenhotelcampinagrande.com.br/slides/14-09-2013.163727_slide.jpg",
            "http://www.tornosnews.gr/files/negroponteresort_175_1_594149974.png",
            "http://www.college-hotel.com/client/cache/contenu/_500____college-hotelp1diapo1_718.jpg",
            "http://www.rwsentosa.com/portals/0/rws%20revamp/hotels/hard%20rock%20hotel/Gallery/Enlarge/HRH01.jpg"
        ].randomElement()
}

func randomId() -> Node {
    return Node.string(NSUUID().uuidString)
}
