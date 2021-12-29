import Foundation

struct ResponseCurrentWeatherModel: Codable {

    struct Weather: Codable {
        let icon: String
    }

    struct Main: Codable {
        let temp: Double
    }

    let weather: [Weather]
    let main: Main
    let name: String
}
