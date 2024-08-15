import Foundation

struct QuestionModel {
    let question: String
    let options: [String]
    let correctAnswer: String

    init(q: String, a: [String], correctAnswer: String) {
        self.question = q
        self.options = a
        self.correctAnswer = correctAnswer
    }
}
