//
//  ResponseModel.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 24.11.2021.
//

import Foundation

struct ResponseModel: Codable { // TODO: Сheck which variables can be optional
    let cod: String
    let message: Int
    let cnt: Int
    let list: [List]
    let city: City
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dt_txt: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let sea_level: Double
    let grnd_level: Double
    let humidity: Double
    let temp_kf: Double
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
