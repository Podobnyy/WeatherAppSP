//
//  SettingsManager.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 08.12.2021.
//

import Foundation

enum Hour: String, CaseIterable {
    case twelve = "12", twentyFour = "24"
}

enum Unit: String, CaseIterable {
    case celsius = "°C", fahrenheit = "°F"
}

enum Distance: String, CaseIterable {
    case kilometre = "km", mile = "mile"
}

enum Details: String, CaseIterable {
    case humidity = "Humidity", windSpeed = "Wind Speed", minTemp = "Min Temp",
         maxTemp = "Max Temp", feelsLike = "Feels Like", pressure = "Pressure"
}

class SettingsManager {

    static let shared = SettingsManager()

    private init() {}

    private var valueHour = Hour.twentyFour
    private var valueUnit = Unit.celsius
    private var valueDistance = Distance.kilometre

    private var humidityDetails = WeatherDetailsModel(nameDetailParameter: Details.humidity.rawValue, isOn: true)
    private var windSpeedDetails = WeatherDetailsModel(nameDetailParameter: Details.windSpeed.rawValue, isOn: true)
    private var minTempDetails = WeatherDetailsModel(nameDetailParameter: Details.minTemp.rawValue, isOn: true)
    private var maxTempDetails = WeatherDetailsModel(nameDetailParameter: Details.maxTemp.rawValue, isOn: true)
    private var feelsLikeDetails = WeatherDetailsModel(nameDetailParameter: Details.feelsLike.rawValue, isOn: true)
    private var pressureDetails = WeatherDetailsModel(nameDetailParameter: Details.pressure.rawValue, isOn: true)

    // MARK: - funcs
    func setSettings(parameter: Any, value: Int) {
        switch parameter {
        case is Hour.Type:
            if value <= (Hour.allCases.count - 1) {
                valueHour = Hour.init(rawValue: Hour.allCases[value].rawValue)!
            }
        case is Unit.Type:
            if value <= (Unit.allCases.count - 1) {
                valueUnit = Unit.init(rawValue: Unit.allCases[value].rawValue)!
            }
        case is Distance.Type:
            if value <= (Distance.allCases.count - 1) {
                valueDistance = Distance.init(rawValue: Distance.allCases[value].rawValue)!
            }
        default:
            break
        }
    }

    // MARK: - Get funcs
    func getValueHour() -> Hour {
        return valueHour
    }

    func getValueUnit() -> Unit {
        return valueUnit
    }

    func getValueDistance() -> Distance {
        return valueDistance
    }

    // MARK: - Get Details funcs
    func getWeatherDetails(nameDetailParameter: Details) -> WeatherDetailsModel {
        switch nameDetailParameter {
        case .humidity: return humidityDetails
        case .windSpeed: return windSpeedDetails
        case .minTemp: return minTempDetails
        case .maxTemp: return maxTempDetails
        case .feelsLike: return feelsLikeDetails
        case .pressure: return pressureDetails
        }
    }
}
