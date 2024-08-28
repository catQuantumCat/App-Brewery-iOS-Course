

import UIKit

class HomeVC: UIViewController {
    
    var brain = CalculatorBrain()
    
    // Outlets

    @IBOutlet private var weightSlider: UISlider!

    @IBOutlet private var heightSlider: UISlider!

    @IBOutlet var heightLabel: UILabel!

    @IBOutlet var weightLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        heightLabel.text = String(format: "%.2f m", sender.value)
    }
    @IBAction func weightSliderChanged(_ sender: UISlider){
        weightLabel.text = String(format: "%.0f Kg", sender.value)
    }
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        brain.calculateBMI(weight: weightSlider.value, height: heightSlider.value)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
}

extension HomeVC {
    private func setup() {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destination = segue.destination as! ResultVC
            destination.bgColor = brain.getColorBMI()
            destination.quote = brain.getQuoteBMI()
            destination.score = brain.getIndexBMI()
        }
    }
}
