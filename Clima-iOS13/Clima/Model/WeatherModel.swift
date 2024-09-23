import Foundation

struct WeatherModel {
    let temp: Double
    let conditionId: Int
    let name: String

    var iconName: String {
        switch conditionId {
        case 200...232:
            return WeatherConditionEnum.Thunderstorm.rawValue
        case 300...321:
            return WeatherConditionEnum.Drizzle.rawValue
        case 500...531:
            return WeatherConditionEnum.Rain.rawValue
        case 600...622:
            return WeatherConditionEnum.Snow.rawValue
        case 701...781:
            return WeatherConditionEnum.Atmosphere.rawValue
        case 800:
            return WeatherConditionEnum.Clear.rawValue
        case 801...804:
            return WeatherConditionEnum.Clouds.rawValue
        default:
            return WeatherConditionEnum.Error.rawValue
        }
    }
}

// "main": {
//   "temp": 298.48,
//   "feels_like": 298.74,
//   "temp_min": 297.56,
//   "temp_max": 300.05,
//   "pressure": 1015,
//   "humidity": 64,
//   "sea_level": 1015,
//   "grnd_level": 933
// },
