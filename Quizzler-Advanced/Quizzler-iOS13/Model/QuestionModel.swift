import Foundation


class QuestionModel{
    let text: String
    let options: [String]
    let correctAnswer: String
    
    
    func checkAnswer(with userInput: String) -> Bool{
        return userInput == correctAnswer ? true : false
    }
    
    init(q: String, a: [String], correctAnswer: String) {
        self.text = q
        self.options = a
        self.correctAnswer = correctAnswer
    }
}
