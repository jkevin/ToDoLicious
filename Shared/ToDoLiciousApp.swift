//
//  ToDoLiciousApp.swift
//  Shared
//
//  Created by J. Kevin Corcoran on 3/3/22.
//

import SwiftUI

@main
struct ToDoLiciousApp: App {
    @StateObject private var store = TodoListStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(todoLists: $store.todoLists) {
                    TodoListStore.save(todoLists: store.todoLists) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                TodoListStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let todoLists):
                        store.todoLists = todoLists
                    }
                }
            }
            
        }
    }
}
