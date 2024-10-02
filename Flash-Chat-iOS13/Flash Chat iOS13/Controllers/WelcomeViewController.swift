import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension WelcomeViewController {
    func setup() {
        labelAnimation(for: titleLabel, with: "⚡FlashChat")
    }
    
    func labelAnimation(for label: UILabel, with targetText: String) {
        
        
        label.text = ""
        
        
        for i in  0..<targetText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300 * i)){
                
                label.text! += targetText[i]
            }
        }
    }
}
