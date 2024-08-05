//
//  ViewController.swift
//  TODO
//
//  Created by Shashi Gupta on 02/08/24.
//

import UIKit
import SwiftUI



class ViewController: UIViewController {
    
    private let toDoViewModel = ToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.fetchToDo(id: 4)
        
//        Task{
//            await process()
//        }
    }
    
    func fetchNumbers() async -> [Int]{
        return [1,2,3,5,4,7,8,6]
    }
    
    func getNumber() async -> Int{
        
        return Int.random(in: 1...10)
    }
    
    func calculateTotal(numbers:[Int]) async -> Int{
        var total : Int = 0
        for number in numbers{
            total += number
        }
        
        return total
    }
    
    func printTotal(total:Int) async{
        print("Total is \(total)")
    }
    
    func process() async{
        
        let numbers = await fetchNumbers()
        print(numbers)
//        async let number1 = getNumber()
//        async let number2 = getNumber()
//        async let number3 = getNumber()
        
        let total = await calculateTotal(numbers: numbers)
        print(total)
        
        let printData = await printTotal(total: total)
        print(printData)
    }
    
    func fetchToDo(id:Int){
        
        self.toDoViewModel.getToDo(id: id)
        
        self.toDoViewModel.todoUpdated = {[weak self] in
            guard let todo = self?.toDoViewModel.todo else {
                return
            }
            
            print(todo)
        }
    }
    
    
    @IBAction func toDoList(_ sender: Any) {
        self.showToListInSwiftUI()
    }
    
    func showToListInSwiftUI(){
        
        let listView = TodoList()
        let vc = UIHostingController(rootView: listView)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
