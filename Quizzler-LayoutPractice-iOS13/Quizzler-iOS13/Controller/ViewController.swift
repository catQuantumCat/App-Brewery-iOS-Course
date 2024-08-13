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
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var trueButton: UIButton!
    @IBOutlet private weak var falseButton: UIButton!
    @IBOutlet private weak var questionText: UILabel!
    @IBOutlet private weak var progressBar: UIProgressView!
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
        progressBar.progress = localRepo.getCurrentProgress()
        scoreLabel.text = "Your score: " + localRepo.getScoreString()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(200)) { [weak self] in
            self?.trueButton.backgroundColor = UIColor.clear
            self?.falseButton.backgroundColor = UIColor.clear
        }
    }

    private func validateAnswer(with button: UIButton) {
        guard let userAnswer = button.titleLabel?.text else {
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
