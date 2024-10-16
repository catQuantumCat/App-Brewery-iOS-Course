import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension WelcomeViewController {
    func setup() {
        labelAnimation(for: titleLabel, with: Constants.appTitle)
        
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
