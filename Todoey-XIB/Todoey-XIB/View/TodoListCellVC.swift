//
//  TodoListCellVC.swift
//  Todoey-XIB
//
//  Created by Huy on 8/1/25.
//

import UIKit

class TodoListCellVC: UITableViewCell {
    
    @IBOutlet weak var titleText: UILabel!
    
    private var todo : TodoModel? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    public func configure(with data: TodoModel) {
        self.todo = data

        if let todo{
            titleText.text = todo.title
            self.accessoryType = todo.status == true ? .checkmark : .none
        }

    }
}
