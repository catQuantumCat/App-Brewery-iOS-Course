//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet private var progressBar: UIProgressView!
    @IBOutlet private var topTitle: UILabel!
    private var timer: Timer?
    
    private var audioPlayer: AVAudioPlayer?
    
    private let boilTimeInSeconds: [String: Int] = [
        "soft": 5 * 60,
        "medium": 7 * 60,
        "hard": 12 * 60
    ]
    
    override func viewDidLoad() {}
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 0
        
        guard let selectedTitle = sender.titleLabel?.text?.lowercased(),
              let seconds = boilTimeInSeconds[selectedTitle]
        else {
            print("Title not found")
            return
        }
        endTimer()
        topTitle.text = selectedTitle
        startTimer(forSeconds: seconds)
    }
}

extension ViewController {
    func startTimer(forSeconds durationSeconds: Int) {
        var currentSecond: Int = durationSeconds
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            
            guard let self = self else {
                return
            }
            
            currentSecond -= 1
            progressBar.progress = 1.0 - (Float(currentSecond) / Float(durationSeconds))
            
            if currentSecond == 0 {
                self.topTitle.text = "DONE!"
                self.endTimer()
                playAlarm()
            }
        }
        if let timer = timer {
            RunLoop.current.add(timer, forMode: .common)
        }
    }
    
    func endTimer() {
        if let timer = timer {
            timer.invalidate()
        }
    }
    
    func playAlarm() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
            return
        }
        
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    }
}
