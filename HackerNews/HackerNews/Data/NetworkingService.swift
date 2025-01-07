import Foundation

enum APIError: Error {
    case urlError(String = "Not correct URL")
    case unknownError(String = "Unknown")
    case networkError(String)
    case noResponseError(String = "No response")
    case decodingError(String)
}

class NetworkingService {
    func fetchData(completion: @escaping (Result<NewsResponseDTO, APIError>) -> Void) {
        guard let url = URL(string: Constants.API.searchURL) else {
            print("URL error")
            completion(.failure(APIError.urlError()))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let error {
                print(error.localizedDescription)
                completion(.failure(APIError.networkError(error.localizedDescription)))
                return
            }
            
            guard let response else {
                completion(.failure(APIError.noResponseError()))
                print("No response")
                return
            }
            
            if let data {
                let decoder = JSONDecoder()
                
                do {
                    let decodedData = try decoder.decode(NewsResponseDTO.self, from: data)

                    completion(.success(decodedData))
                    return
                    
                } catch let err {
                    print("Failed \(err)")
            
                    completion(.failure(APIError.decodingError(err.localizedDescription)))
                }
            }
            
            else {
                print("Failed \(response.description)")
                completion(.failure(APIError.unknownError("Unknown - no data: \(response.description)")))
                return
            }
        }.resume()
    }
}
