import Foundation
import RealmSwift


class CategoryModel: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""

    convenience init(name: String, color: String = ""){
        self.init()
        self.self.name = name
        self.self.color = color
    }
    //Relationship to parent
    let todos = List<TodoModel>()
}
