import Foundation

struct WeatherResponseDTO : Decodable{
    let main: WeatherMainResponseDTO
    let weather: [WeatherWeatherResponseDTO]
    let name: String
    
    func toModel() -> WeatherModel{
        return WeatherModel(temp: main.temp, conditionId: weather.first?.id ?? 0 , name: name)
    }
}


struct WeatherMainResponseDTO : Decodable{
    let temp: Double
}

struct WeatherWeatherResponseDTO:Decodable{
    let id: Int
}
