import UIKit

class QuizzVC: UIViewController {
    // Variables
    private let viewModel = QuizzVM()

    // Outlets
    @IBOutlet private weak var scoreLabel: UILabel!

    @IBOutlet private weak var firstOptionButton: UIButton!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var secondOptionButton: UIButton!
    @IBOutlet private weak var thirdOptionButton: UIButton!

    @IBOutlet private weak var progressBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func optionTapped(_ sender: UIButton) {
        guard let answer = sender.titleLabel?.text else{
            return
        }
        optionsFeedback(for: sender, isCorrect: viewModel.validateAnswer(userAnswer: answer))
        resetAfterDelay()
    }
}

extension QuizzVC {
    private func setupUI() {
        updateScore()
        updateQuestion()
        updateOptions()
        updateProgressBar()
    }

    
    private func updateProgressBar(){
        progressBar.progress = viewModel.getProgress()
    }
    
    private func updateQuestion() {
        questionLabel.text = viewModel.getQuestion()
    }

    private func updateOptions() {
        let potentialAnswers: [String] = viewModel.getOptions()

        firstOptionButton.setTitle(potentialAnswers[0], for: .normal)
        secondOptionButton.setTitle(potentialAnswers[1], for: .normal)
        thirdOptionButton.setTitle(potentialAnswers[2], for: .normal)
    }

    private func updateScore() {
        scoreLabel.text = "Score: \(viewModel.getScore())"
    }

    private func optionsFeedback(for button: UIButton, isCorrect: Bool) {
        button.tintColor = isCorrect == true ? UIColor.systemGreen : UIColor.systemRed
    }

    private func resetAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) { [weak self] in
            self?.firstOptionButton.tintColor = UIColor.systemBlue
            self?.secondOptionButton.tintColor = UIColor.systemBlue
            self?.thirdOptionButton.tintColor = UIColor.systemBlue
            
            self?.setupUI()
        }
    }
}
