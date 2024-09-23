

import Foundation
import CoreLocation

enum APIError: Error {
    case generic(String)
}

class RemoteRepository {
    let baseURL: String
    let API_KEY: String = "API_KEY"
    init(){

        baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(API_KEY)&units=metric"
        
    }
    
    func fetchData(cityName: String, completion: @escaping (Result<WeatherModel, APIError>) -> Void){
        performRequest(url: "\(baseURL)&q=\(cityName)", completion: completion)
    }
    
    func fetchData(location: CLLocation, completion: @escaping (Result<WeatherModel, APIError>) -> Void){
        performRequest(url: "\(baseURL)&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)", completion: completion)
        
    }
    
    func performRequest(url urlString: String, completion: @escaping (Result<WeatherModel, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.generic("URL not valid")))
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(APIError.generic(error.localizedDescription)))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let d = try decoder.decode(WeatherResponseDTO.self, from: data)
                    
                    completion(.success(d.toModel()))
                }
                catch {
                    print(error)
                }
                return
            }
            
        }.resume()
    }
}

