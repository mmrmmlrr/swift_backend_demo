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
