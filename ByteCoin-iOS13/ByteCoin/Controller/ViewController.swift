//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let coinManager: CoinManager = .init()

    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var bitcoinLabel: UILabel!
    @IBOutlet var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getCoin(for: coinManager.currencyArray[row])
    }
}

extension ViewController {
    private func setup() {
        currencyPicker.delegate = self
    }
    
    private func getCoin(for currency: String) {
        coinManager.getCoinPrice(for: currency) { result in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                
                switch result {
                case .success(let data):
                    self.bitcoinLabel.text = data
                    self.currencyLabel.text = currency
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
