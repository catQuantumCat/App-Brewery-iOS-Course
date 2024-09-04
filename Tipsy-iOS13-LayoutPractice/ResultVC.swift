import UIKit

class ResultVC: UIViewController {
    var totalBill: Float?
    var selectedTip: Float?
    var numOfSplit: Double?

    @IBOutlet var recalulateButton: UIButton!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    override func viewDidLoad() {
        setup()
    }

    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension ResultVC {
    private func setup() {
        guard let totalBill = totalBill,
              let selectedTip = selectedTip,
              let numOfSplit = numOfSplit
        else {
            totalLabel.text = "N/A"
            descriptionLabel.text = "Something went wrong, please try again"
            return
        }

        let res = (totalBill * (1 + selectedTip)) / Float(numOfSplit)
        totalLabel.text = String(format: "%.2f", res)
        
        descriptionLabel.text = String(format: "Split between %.0f people, with %.0f%% tip", arguments: [numOfSplit, selectedTip * 100]) 
    }
}
