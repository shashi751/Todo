//
//  TodoList.swift
//  TODO
//
//  Created by Shashi Gupta on 02/08/24.
//

import SwiftUI

struct TodoList: View {
    
    @ObservedObject private var toDoViewModel = ToDoViewModel()
    
    var body: some View {
        
        VStack{
            Text("TODO List")
                .font(.largeTitle)
            List(toDoViewModel.toDos) { todo in
                Row(todoModel: todo)
            }
            
        }
        .task {
            toDoViewModel.getToDoList()
        }
    }
}

#Preview {
    TodoList()
}
