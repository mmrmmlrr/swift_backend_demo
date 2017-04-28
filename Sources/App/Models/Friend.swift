//
//  Friend.swift
//  MyBackend
//
//  Created by Oleksii Chernysh on 4/28/17.
//
//

import Foundation
import Vapor

struct Friend {
    let name: String
    let age: Int
    var id: Node?
}

extension Friend: Model {
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    init(node: Node, in context: Context) throws {
        name = try node.extract("name")
        age = try node.extract("age")
    }
    
    func makeNode() throws -> Node {
        return try! Node(node: ["name": name, "age": age])
    }
    func makeNode(context: Context) throws -> Node {
        return try Node(node: ["name": name, "age": age])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("friends") { friends in
            friends.id()
            friends.string("name")
            friends.int("age")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("friends")
    }
    
}
