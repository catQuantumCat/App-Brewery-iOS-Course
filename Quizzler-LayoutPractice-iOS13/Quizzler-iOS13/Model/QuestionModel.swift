import Foundation


class QuestionModel{
    let text: String
    let answer: String
    
    
    func checkAnswer(with userInput: String) -> Bool{
        return userInput == answer ? true : false
    }
    
    init(q: String, a: String) {
        self.text = q
        self.answer = a
    }
}
