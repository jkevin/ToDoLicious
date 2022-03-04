//
//  ContentView.swift
//  Shared
//
//  Created by J. Kevin Corcoran on 3/3/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var todoLists: [TodoList]
    @Environment(\.scenePhase) private var scenePhase
    @State var showNewListForm = false
    @State var newTodoListName: String = ""
    @State var isEditing = false
    let saveAction: ()->Void
    
    var body: some View {
        VStack {
            List() {
                if(todoLists.isEmpty) {
                    Text("No todo lists!").scaledToFill()
                } else {
                    ForEach($todoLists) { $todoList in
                    NavigationLink(destination: TodoListView(todoList: $todoList)) {
                        Text(todoList.title)
                    }
                    }.onDelete {toDelete in
                        todoLists.remove(atOffsets: toDelete)
                        if todoLists.isEmpty {
                            // stop editing if deleting last item
                            isEditing = false
                        }
                    }.listRowSeparator(.hidden)
                }
            }
            Button(action: {
                showNewListForm = true
            }) {
                Text("New List")
            }.padding()
        }.environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
            .navigationTitle("My Todo Lists")
            .toolbar {
                if(!todoLists.isEmpty) {
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
            }.sheet(isPresented: $showNewListForm) {
                NewItemForm(formTitle: "Create Todo List",
                            textLabel: "Title",
                            showNewItemForm: $showNewListForm) {todoListTitle in
                    todoLists.append(TodoList(title: todoListTitle))
                }
            }.onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ContentView(todoLists: .constant(TodoList.sampleData), saveAction: {})
                    .previewInterfaceOrientation(.portrait)
            }
        }
    }
