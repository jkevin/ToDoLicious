//
//  TodoListView.swift
//  ToDoLicious (iOS)
//
//  Created by J. Kevin Corcoran on 3/3/22.
//

import SwiftUI

struct TodoListView: View {
    @Binding var todoList: TodoList
    @State var showNewTodoForm = false
    @State var newTodoName = ""
    @State var isEditing = false
    
    var body: some View {
        VStack {
            List() {
                if(todoList.todos.isEmpty) {
                    Text("No todos!")
                } else {
                    ForEach($todoList.todos) {$todo in
                        Toggle(todo.name, isOn: $todo.completed).toggleStyle(.switch)
                    }.onDelete {toDelete in
                        todoList.todos.remove(atOffsets: toDelete)
                        if todoList.todos.isEmpty {
                            // stop editing if deleting last item
                            isEditing = false
                        }
                    }
                }
            }
            Button(action: {
                showNewTodoForm = true
            }) {
                Text("New Todo")
            }.padding()
        }.environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
        .toolbar {
            if !todoList.todos.isEmpty {
                Button(action: {
                    isEditing = !isEditing
                }) {
                    if(isEditing) {
                        Text("Done")
                    } else {
                        Text("Edit")
                    }
                }
            }
        }.sheet(isPresented: $showNewTodoForm) {
            NewItemForm(formTitle: "Create Todo",
                        textLabel: "Name",
                        showNewItemForm: $showNewTodoForm) {todoName in
                todoList.todos.append(Todo(name: todoName))
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoListView(todoList: .constant(TodoList.sampleData[0]))
                .previewInterfaceOrientation(.portrait)
        }
    }
}
