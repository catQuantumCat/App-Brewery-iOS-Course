//
//  todoModel.swift
//  Todoey-XIB
//
//  Created by Huy on 10/2/25.
//

import Foundation
import RealmSwift

class TodoModel: Object {
    convenience init(title: String = "", status: Bool = false, createdDate: Date = Date()) {
        self.init()
        self.title = title
        self.status = status
        self.createdDate = createdDate
    }
    
    @objc dynamic var title: String = ""
    @objc dynamic var status: Bool = false
    @objc dynamic var createdDate: Date = .init()
    
    // Relationship to child
    var category: LinkingObjects = .init(fromType: CategoryModel.self, property: "todos")
}
