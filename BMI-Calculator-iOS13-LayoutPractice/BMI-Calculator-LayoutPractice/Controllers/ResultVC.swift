import UIKit

class ResultVC: UIViewController {
    
    var score: String?
    var quote: String?
    var bgColor: UIColor?
    
    @IBOutlet var recalculateButton: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @IBAction func recalculateButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension ResultVC {
    private func setupUI() {
        scoreLabel.text = score
        descriptionLabel.text = quote
        view.backgroundColor = bgColor
    }
}
