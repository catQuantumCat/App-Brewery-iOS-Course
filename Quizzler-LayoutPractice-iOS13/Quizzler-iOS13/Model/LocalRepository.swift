import Foundation

class LocalRepository {
    private let questions: [QuestionModel] = DummyData
    private var currentQuestion = 0
    private var score = 0
}

extension LocalRepository {
    
    func getQuestion() -> String {
        return questions[currentQuestion].text
    }
    
    func getCurrentProgress() -> Float {
        return Float(currentQuestion + 1) / Float(questions.count)
    }
    
    func getScoreString() -> String {
        String(score)
    }
    
    func validateQuestion(answer userAnswer: String) -> Bool {
        var toReturn = false
        if questions[currentQuestion].answer == userAnswer {
            score += 1
            toReturn = true
        }

        nextQuestion()
        return toReturn
    }
    
    func nextQuestion() {
        if currentQuestion == questions.count - 1 {
            currentQuestion = 0
            score = 0
            print("Your score is \(score)")
        }
        
        else {
            currentQuestion += 1
        }
    }
}
