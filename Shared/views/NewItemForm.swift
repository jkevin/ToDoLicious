//
//  NewItemForm.swift
//  ToDoLicious (iOS)
//
//  Created by J. Kevin Corcoran on 3/3/22.
//

import SwiftUI

struct NewItemForm: View {
    let formTitle: String
    let textLabel: String
    @Binding var showNewItemForm: Bool
    let submitAction: (String) -> Void
    @State var newItemText: String = ""
    @State var newTodoName = ""
    
    var body: some View {
        Form {
            Section(formTitle) {
                TextField(textLabel, text: $newItemText)
            }
            Button(action: {
                submitAction(newItemText)
                newItemText = ""
                showNewItemForm = false
            }) {
                Text("Done")
            }.disabled(newItemText.isEmpty)
            Button(action: {
                newItemText = ""
                showNewItemForm = false
            }) {
                Text("Cancel")
            }
        }
    }
}
