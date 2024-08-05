//
//  ToDoViewModel.swift
//  TODO
//
//  Created by Shashi Gupta on 02/08/24.
//

import Foundation


class ToDoViewModel:ObservableObject{
    
    @Published var toDos : [Todo] = [Todo]()
    var todo : Todo? {
        didSet{
            todoUpdated()
        }
    }
    
    var todoUpdated:(() -> Void) = {}
    
    func getToDoList(){
        
        
        Task{
            let list = try await NetworkManager().fetchRequestAsyncAwait(type: [Todo].self, url: "https://jsonplaceholder.typicode.com/todos", method: "GET")
            DispatchQueue.main.async {
                self.toDos = list
            }   
        }
    }
    
    func getToDo(id:Int){
        
        NetworkManager().fetchRequest(type: Todo.self, url: "https://jsonplaceholder.typicode.com/todos/\(id)") {[weak self] result in
            
            switch result{
            case .success(let todo):
                DispatchQueue.main.async {
                    self?.todo = todo
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
