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
    let title: String
    var id: Node?
}

extension Survey: Model {
    
    init(title: String) {
        self.title = title
    }
    
    init(node: Node, in context: Context) throws {
        title = try node.extract("title")
    }
    
    func makeNode() throws -> Node {
        return try! Node(node: ["title": title])
    }
    func makeNode(context: Context) throws -> Node {
        return try Node(node: ["title": title])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("surveys") { friends in
            friends.id()
            friends.string("title")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("surveys")
    }
    
}
