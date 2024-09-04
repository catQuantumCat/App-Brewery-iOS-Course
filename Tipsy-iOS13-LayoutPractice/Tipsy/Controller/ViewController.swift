//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var selectedTip: Float = 0.1
        
    @IBOutlet private var totalField: UITextField!
    
    @IBOutlet private var Tip0Button: UIButton!
    @IBOutlet private var Tip10Button: UIButton!
    @IBOutlet private var Tip20Button: UIButton!
    
    @IBOutlet private var splitStepper: UIStepper!
    @IBOutlet private var splitLabel: UILabel!
    
    @IBOutlet private var calculateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction private func calculateButtonTapped(_ sender: UIButton) {
        
        totalField.endEditing(true)
        performSegue(withIdentifier: "showResult", sender: self)
    }

    @IBAction private func splitStepperTapped(_ sender: UIStepper) {
        splitLabel.text = String(format: "%.0f", sender.value)
    }

    @IBAction private func tipButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectedTip = 0
        case 10:
            selectedTip = 0.1
        case 20:
            selectedTip = 0.2
        default:
            break
        }
        
        Tip0Button.isSelected = false
        Tip10Button.isSelected = false
        Tip20Button.isSelected = false
        
        sender.isSelected = true
    }
}

extension ViewController {
    private func setup() {
        setupButton()
    }
    
    private func setupButton() {
        Tip0Button.tag = 0
        Tip10Button.tag = 10
        Tip20Button.tag = 20
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            if let destination = segue.destination as? ResultVC {
                print("Here")
                destination.numOfSplit = splitStepper.value
                destination.selectedTip = selectedTip
                destination.totalBill = Float(totalField.text ?? "0")
            }
        }
    }
}
