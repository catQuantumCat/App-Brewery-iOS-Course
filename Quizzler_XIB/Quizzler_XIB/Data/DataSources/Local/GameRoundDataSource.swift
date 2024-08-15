import Foundation

protocol GameRoundLocalDataSource {
    func getQuestion() -> String
    func getOptions() -> [String]
    
    func checkAnswer(answer userAnswer: String) -> Bool
    
    func getProgress() -> Float
    func getScore() -> Int
}

class GameRoundLocalDataSourceImp {
    let dummyQuestion: [QuestionModel] = [
        QuestionModel(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        QuestionModel(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        QuestionModel(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        QuestionModel(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        QuestionModel(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        QuestionModel(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        QuestionModel(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        QuestionModel(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        QuestionModel(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        QuestionModel(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]

    var gameRound: GameRoundModel
    
    init() {
        self.gameRound = GameRoundModel(questionList: dummyQuestion)
    }
}

extension GameRoundLocalDataSourceImp: GameRoundLocalDataSource {
    func getQuestion() -> String {
        gameRound.getQuestion()
    }
    
    func getOptions() -> [String] {
        gameRound.getOptions()
    }
    
    func checkAnswer(answer userAnswer: String) -> Bool {
        gameRound.validateAnswer(answer: userAnswer)
    }
    
    func getProgress() -> Float {
        gameRound.getProgress()
    }
    
    func getScore() -> Int {
        gameRound.getScore()
    }
}
