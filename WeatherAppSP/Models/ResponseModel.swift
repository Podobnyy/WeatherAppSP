//
//  ResponseModel.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 24.11.2021.
//

import Foundation

struct ResponseModel: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [List]
    let city: City
}

// MARK: - List
struct List: Codable {
    let dateTime: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case main, weather, clouds, wind, visibility, pop, sys

        case dateTime = "dt"
        case dtTxt = "dt_txt"
    }
}

struct Main: Codable {
    let temp: Double

    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let seaLevel: Double
    let grndLevel: Double
    let humidity: Double
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp

        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity = "humidity"
        case tempKf = "temp_kf"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
    let gust: Double
}

struct Sys: Codable {
    let pod: String
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}
