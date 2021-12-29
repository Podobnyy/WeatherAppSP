import Foundation

struct Forecast {
    let time: Date
    let temp: Double
    let weatherDescription: String
}

struct CityWeather {
    let name: String
    let weatherDescription: String
    let date: Date
    let temp: Double
    let sunrise: Date
    let sunset: Date

    let forecasts: [Forecast]

    let humidity: Double
    let windSpeed: Double
    let tempMin: Double
    let tempMax: Double
    let feelsLike: Double
    let pressure: Double
}
