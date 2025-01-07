import Foundation

class NewsRemoteDatasource{
    let networkingService: NetworkingService = NetworkingService()
    
    
    func fetchNews(completion: @escaping (Result<NewsResponseDTO, APIError>) -> Void)  {
        
        return networkingService.fetchData(completion: completion)
    }
}
