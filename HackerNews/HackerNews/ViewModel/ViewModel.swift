import Foundation

extension ContentView{
    class ViewModel : ObservableObject{
        @Published var newsList : [News] = []
        
        var onNewsUpdate : (() -> Void)?
        var onError : ((APIError) -> Void)?
        
        let repository : NewsRepository = NewsRepository(remoteDatasource: NewsRemoteDatasource())
        
        init(){
//            self.onNewsUpdate = onNewsUpdate
//            self.onError = onError
//            fetchNews()
        }

        func fetchNews(){

            return repository.fecthNews { [weak self] result in
                
                DispatchQueue.main.async {
                    guard let self else { return }
                    
                    switch result{
                    case .success(let news):
                        print(news[0])
                        self.newsList = news
                        self.onNewsUpdate?()
                    case .failure(let error):
                        print(error)
                        self.onError?(error)
                    }
                }
                
                
            }
            
        }
    }
}

