//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Huy on 12/10/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    private var messageData: MessageModel? = nil

    @IBOutlet weak var leftAvatarImage: UIImageView!
    @IBOutlet private weak var rightAvatarImage: UIImageView!
    @IBOutlet private weak var messageBubble: UIView!
    @IBOutlet private weak var messageContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private func setup(){
        guard let messageData else { return }
        messageContent.text = messageData.body
    }
    
    func configure(with message: MessageModel, isSelf: Bool){
        self.messageData = message
        setup()
        
        if isSelf {
            setupSelfMessage()
            return
        } else {
            setupGuessMessage()
            return
        }
    }
    
    private func setupUI(){
        messageBubble.layer.cornerRadius = 10
        
    }
    
    private func setupGuessMessage(){
        rightAvatarImage.isHidden = true
        leftAvatarImage.isHidden = false
        messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
        messageContent.textColor = UIColor(named: Constants.BrandColors.purple)
    }
    
    private func setupSelfMessage(){
        rightAvatarImage.isHidden = false
        leftAvatarImage.isHidden = true

        messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.purple)
        messageContent.textColor = UIColor(named: Constants.BrandColors.lightPurple)
    }
}
