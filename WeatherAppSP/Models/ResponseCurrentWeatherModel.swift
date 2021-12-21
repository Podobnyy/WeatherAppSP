//
//  ResponseCurrentWeatherModel.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 21.12.2021.
//

import Foundation

struct ResponseCurrentWeatherModel: Codable {

    let weather: [Weather]
    let main: Main
    let name: String

    struct Weather: Codable {
        let icon: String
    }

    struct Main: Codable {
        let temp: Double
    }
}
