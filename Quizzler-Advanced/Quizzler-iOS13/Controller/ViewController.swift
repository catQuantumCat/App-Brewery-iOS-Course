//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // variables
    let localRepo: LocalRepository = .init()

    // outlets
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var questionText: UILabel!

    @IBOutlet private var firstOption: UIButton!
    @IBOutlet private var secondOption: UIButton!
    @IBOutlet private var thirdOption: UIButton!

    @IBOutlet private var progressBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        validateAnswer(with: sender)
        updateUI()
    }
}

extension ViewController {
    private func setup() {
        updateUI()
    }

    private func updateUI() {
        questionText.text = localRepo.getQuestion()
        updateOptionLabels(using: localRepo.getOptions())

        progressBar.progress = localRepo.getCurrentProgress()
        scoreLabel.text = "Your score: " + localRepo.getScoreString()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(200)) { [weak self] in
            self?.resetOptionColor()
        }
    }

    private func updateOptionLabels(using optionList: [String]) {
        firstOption.setTitle(optionList[0], for: .normal)
        secondOption.setTitle(optionList[1], for: .normal)
        thirdOption.setTitle(optionList[2], for: .normal)
    }
    
    private func resetOptionColor(){
        firstOption.backgroundColor = UIColor.clear
        secondOption.backgroundColor = UIColor.clear
        thirdOption.backgroundColor = UIColor.clear
    }

    private func validateAnswer(with button: UIButton) {
        guard let userAnswer = button.titleLabel?.text else {
            print("HERE")
            
            return
        }

        if localRepo.validateQuestion(answer: userAnswer) {
            button.backgroundColor = UIColor.green
        }

        else {
            button.backgroundColor = UIColor.red
        }
    }
}
