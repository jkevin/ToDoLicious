//
//  TodoListStore.swift
//  ToDoLicious (iOS)
//
//  Created by J. Kevin Corcoran on 3/3/22.
//

import Foundation
import SwiftUI

class TodoListStore: ObservableObject {
    @Published var todoLists: [TodoList] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("todos.data")
    }
    
    static func load(completion: @escaping (Result<[TodoList], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let todoLists = try JSONDecoder().decode([TodoList].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(todoLists))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(todoLists: [TodoList], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(todoLists)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(todoLists.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

}
