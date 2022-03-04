//
//  Todo.swift
//  ToDoLicious (iOS)
//
//  Created by J. Kevin Corcoran on 3/3/22.
//

import Foundation

struct Todo: Identifiable, Codable {
    let id: UUID
    
    var name: String
    var completed: Bool
    
    init(id: UUID = UUID(), name: String, completed: Bool = false) {
        self.id = id
        self.name = name
        self.completed = completed
    }
}
