//
//  CategoryCell.swift
//  Todoey-XIB
//
//  Created by Huy on 6/2/25.
//

import UIKit

class CategoryCell: UITableViewCell
{

    //MARK: IB PROPERTIES
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//MARK: - CONFIG

extension CategoryCell{
    func configure(with category: CategoryModel?){
        guard let category else{
            label.text = "No category found"
            return
        }
        label.text = category.name
        label.textColor = UIColor(hex: category.color)?.contrastColor
        self.backgroundColor = UIColor(hex: category.color)
    }
}
