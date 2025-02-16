//
//  TodoListCellVC.swift
//  Todoey-XIB
//
//  Created by Huy on 8/1/25.
//

import UIKit

class TodoListCellVC: UITableViewCell {
    
    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var dateText: UILabel!
    private var todo : TodoModel? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    public func configure(with data: TodoModel?, color: UIColor = .white) {
        self.todo = data
        self.backgroundColor = color
        
        self.titleText.textColor = color.contrastColor
        self.dateText.textColor = color.contrastColor.withAlphaComponent(0.5)

        if let todo {
            titleText.text = todo.title
            dateText.text = todo.createdDate.formatted()
            self.accessoryType = todo.status == true ? .checkmark : .none
        }

    }
}
