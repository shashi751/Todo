//
//  Row.swift
//  TODO
//
//  Created by Shashi Gupta on 02/08/24.
//

import SwiftUI

struct Row: View {
    
    var todoModel:Todo
    
    var body: some View {
        
        VStack(alignment:.leading){
            HStack(alignment:.top){
                Text("\(todoModel.id). ")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.black)
                Text("\(todoModel.title.capitalized)")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundStyle(.gray)
                
            }
            Text(todoModel.completed ? "Completed" : "Pending")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(todoModel.completed ? .green : .red)
                .padding(.top, 4)
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }
}

#Preview {
    Row(todoModel: Todo(userId: 1, id: 1, title: "Test Todo", completed: false))
}
