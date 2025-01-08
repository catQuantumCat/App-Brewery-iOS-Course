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
        
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public func configure(with data: TodoModel) {
        self.todo = data
        
        
        if let todo{
            titleText.text = todo.title
            
            if (todo.status == true){
                self.accessoryType = .checkmark
            }
        }
        
        
    }
    
    public func onTap(status: Bool? = nil){
        guard let todo else { return }
        
        self.todo?.toggleStatus(with: status ?? !todo.status)
        self.accessoryType = self.todo?.status ?? false ? .checkmark : .none
    }
    
}
