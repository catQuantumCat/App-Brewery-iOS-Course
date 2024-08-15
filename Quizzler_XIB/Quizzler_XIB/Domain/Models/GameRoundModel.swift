import Foundation

struct GameRoundModel {
    let questionList: [QuestionModel]
    private var score: Int
    private var currentQuestion: Int
    
    init(questionList: [QuestionModel]) {
        self.questionList = questionList
        self.score = 0
        self.currentQuestion = 0
    }
}

extension GameRoundModel {
    mutating func updateIndexes(isCorrect: Bool) {
        if currentQuestion == questionList.count - 1 {
            resetGame()
            return
        }
        if isCorrect {
            score += 1
        }
        currentQuestion += 1
    }
    
    func getScore() -> Int {
        score
    }
    
    func getProgress() -> Float {
        Float(currentQuestion + 1) / Float(questionList.count)
    }
    
    private mutating func resetGame() {
        currentQuestion = 0
    }
}

extension GameRoundModel {
    func getQuestion() -> String {
        questionList[currentQuestion].question
    }
    
    func getOptions() -> [String] {
        questionList[currentQuestion].options
    }
    
    mutating func validateAnswer(answer userAnswer: String) -> Bool {
        let toReturn = userAnswer == questionList[currentQuestion].correctAnswer
        self.updateIndexes(isCorrect: toReturn)
        return toReturn
    }
}
 
