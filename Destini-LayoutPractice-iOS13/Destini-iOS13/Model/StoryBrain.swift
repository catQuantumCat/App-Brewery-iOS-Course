import Foundation


class StoryBrain{
    private let data : [Story]
    var currentStoryIndex: Int = 0
    
    init() {
        self.data = dummyData
    }
}

extension StoryBrain{
    private func updateCurrentStory(choice index: Int){
        guard index < data.count else{
            self.currentStoryIndex = 0
            return
        }
        self.currentStoryIndex = index
    }
    
    
    func getStory() -> String{
        return data[currentStoryIndex].title
    }
    
    func getOptions() -> [String]{
        let currentStory = data[currentStoryIndex]
        return [currentStory.choice1, currentStory.choice2]
    }
    
    
    func navigateToStory(choice: Int){
        switch choice{
        case 1:
            updateCurrentStory(choice: data[currentStoryIndex].choice1Destination)
        case 2:
            updateCurrentStory(choice: data[currentStoryIndex].choice2Destination)
        default:
            break
        }
    }
}


