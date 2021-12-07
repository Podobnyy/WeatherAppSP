//
//  CityWeather.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 24.11.2021.
//

import Foundation

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

struct Forecast {
    let time: Date
    let temp: Double
    let weatherDescription: String
}
