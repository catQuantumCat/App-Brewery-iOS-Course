//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    var player: AVAudioPlayer? = nil
    let DELAY_MILLISECOND_CONSTANT: DispatchTimeInterval = .milliseconds(200)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        buttonWhenPressed(with: sender)
    }
}

extension ViewController {
    func buttonWhenPressed(with button: UIButton) {
        playSound(with: button.titleLabel?.text)
        button.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + DELAY_MILLISECOND_CONSTANT) {
            button.alpha = 1
        }
    }
    
    func playSound(with keyName: String?, audioExtension: String = "wav") {
        guard let keyName else {
            return
        }
        guard let url = Bundle.main.url(forResource: keyName, withExtension: audioExtension) else {
            return
        }
        player = try! AVAudioPlayer(contentsOf: url)
        player!.play()
    }
}
 
