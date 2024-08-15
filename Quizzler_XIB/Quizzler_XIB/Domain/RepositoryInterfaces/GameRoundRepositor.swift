import Foundation

protocol GameRoundRepository{
    func getQuestion() -> String
    func getOptions() -> [String]
    
    func checkAnswer(answer userAnswer: String) -> Bool
    
    func getProgress() -> Float
    func getScore() -> Int
}
