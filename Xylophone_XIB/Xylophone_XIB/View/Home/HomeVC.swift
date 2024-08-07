
import AVFoundation
import UIKit

class HomeVC: UIViewController {
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        buttonTappedAction(button: sender)
    }
}

extension HomeVC {
    func setup() {}
    
    func buttonTappedAction(button: UIButton) {
        
        button.alpha = 0.5
        
        playKey(for: button.titleLabel?.text)
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(200)
        ) {
            button.alpha = 1
        }
    }
    
    func playKey(for name: String?, fileExtension: String = "wav") {
        guard let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
            return
        }
        
        player = try? AVAudioPlayer(contentsOf: url)
        
        guard let player else {
            return
        }
        player.play()
    }
}
