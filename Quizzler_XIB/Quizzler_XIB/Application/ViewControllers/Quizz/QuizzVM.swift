import Foundation

class QuizzVM {
    private let data: GameRoundLocalDataSource = GameRoundLocalDataSourceImp()
}

extension QuizzVM{
    func validateAnswer(userAnswer: String) -> Bool{
        data.checkAnswer(answer: userAnswer)
    }
    
    func getQuestion() -> String{
        data.getQuestion()
    }
    
    func getOptions() -> [String]{
        data.getOptions()
    }
    
    func getScore() -> Int{
        data.getScore()
    }
    
    func getProgress ()-> Float{
        data.getProgress()
    }
    
}
