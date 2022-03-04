//
//  TodoList.swift
//  ToDoLicious (iOS)
//
//  Created by J. Kevin Corcoran on 3/3/22.
//

import Foundation

struct TodoList: Identifiable, Codable {
    let id: UUID
    var title: String
    var todos: [Todo]
    
    init(id: UUID = UUID(), title: String, todos: [Todo] = []) {
        self.id = id
        self.title = title
        self.todos = todos
    }
}

extension TodoList {
    static let sampleData: [TodoList] =
    [
        TodoList(title: "Groceries", todos: [
            Todo(name: "eggs"),
            Todo(name: "bread"),
            Todo(name: "cheese")
        ]),
        TodoList(title: "Work tasks", todos: [
            Todo(name: "build ToDo app", completed: true),
            Todo(name: "reticulate splines")
        ])
    ]
}
