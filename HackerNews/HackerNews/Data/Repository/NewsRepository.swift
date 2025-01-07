import Foundation


class NewsRepository {
    
    let remoteDatasource: NewsRemoteDatasource
    
    init(remoteDatasource: NewsRemoteDatasource) {
        self.remoteDatasource = remoteDatasource
    }
    
    
    func fecthNews(completion: @escaping (Result<[News], APIError>) -> Void) {
        
        
        
        return remoteDatasource.fetchNews { result in
            switch result {
            case .success(let news):
                
                completion(.success(news.toModel()))
            case .failure(let error):
                
                completion(.failure(error))
            }
        }
    }
}
