import Foundation

final class GameRoundRepositoryImp{
    private let localDataSource: GameRoundLocalDataSource = GameRoundLocalDataSourceImp()
}

extension GameRoundRepositoryImp : GameRoundRepository{
    func getQuestion() -> String {
        localDataSource.getQuestion()
    }
    
    func getOptions() -> [String] {
        localDataSource.getOptions()
    }
    
    func checkAnswer(answer userAnswer: String) -> Bool {
        localDataSource.checkAnswer(answer: userAnswer)
    }
    
    func getProgress() -> Float {
        localDataSource.getProgress()
    }
    
    func getScore() -> Int {
        localDataSource.getScore()
    }

}
