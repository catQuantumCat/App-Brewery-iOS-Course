
//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let vm = StoryBrain()
    
    @IBOutlet private weak var storyLabel: UILabel!
    @IBOutlet private weak var topButton: UIButton!
    @IBOutlet private weak var bottomButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag{
        case Constants.TOP_BUTTON_ID:
            vm.navigateToStory(choice: 1)
        case Constants.BOTTOM_BUTTON_ID:
            vm.navigateToStory(choice: 2)
        default:
            vm.navigateToStory(choice: 1)
        }
        
        updateUI()
    }
}
extension ViewController{
    func setup(){
        buttonSetup()
        updateUI()
        
    }
    private func buttonSetup(){
        let bottomButtonImage = UIImage(named: "choice2Background")
        let topButtonImage = UIImage(named: "choice1Background")
        
        topButton.setBackgroundImage(topButtonImage, for: .normal)
        bottomButton.setBackgroundImage(bottomButtonImage, for: .normal)

        topButton.tag = Constants.TOP_BUTTON_ID
        bottomButton.tag = Constants.BOTTOM_BUTTON_ID
    }
    
    private func updateUI(){
        storyLabel.text = vm.getStory()
        let options = vm.getOptions()

        topButton.setTitle(options[0], for: .normal)
        bottomButton.setTitle(options[1], for: .normal)
    }
}

