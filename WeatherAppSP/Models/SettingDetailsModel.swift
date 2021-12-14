//
//  WeatherDetailsModel.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 13.12.2021.
//

import Foundation

enum Detail: String, CaseIterable {
    case humidity = "Humidity"
    case windSpeed = "Wind Speed"
    case minTemp = "Min Temp"
    case maxTemp = "Max Temp"
    case feelsLike = "Feels Like"
    case pressure = "Pressure"
}

struct SettingDetailsModel {
    let detailParameter: Detail
    var isOn: Bool
}
