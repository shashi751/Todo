//
//  Todo.swift
//  TODO
//
//  Created by Shashi Gupta on 02/08/24.
//

import Foundation

struct Todo: Codable, Identifiable{
    var userId : Int
    var id : Int
    var title : String
    var completed : Bool
    
    init(userId: Int, id: Int, title: String, completed: Bool) {
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    enum CodingKeys: CodingKey {
        case userId
        case id
        case title
        case completed
    }
}
