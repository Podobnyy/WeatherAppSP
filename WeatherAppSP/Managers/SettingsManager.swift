//
//  SettingsManager.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 08.12.2021.
//

import Foundation

enum Hour: String, CaseIterable {
    case twelve = "12"
    case twentyFour = "24"
}

enum Unit: String, CaseIterable {
    case celsius = "°C"
    case fahrenheit = "°F"
}

enum Distance: String, CaseIterable {
    case kilometre = "km"
    case mile = "mile"
}

class SettingsManager {

    static let shared = SettingsManager()

    private init() {}

    private var valueHour = Hour.twentyFour
    private var valueUnit = Unit.celsius
    private var valueDistance = Distance.kilometre

    private var settingDetails = [SettingDetailsModel(detailParameter: Detail.humidity, isOn: true),
                                  SettingDetailsModel(detailParameter: Detail.windSpeed, isOn: true),
                                  SettingDetailsModel(detailParameter: Detail.minTemp, isOn: true),
                                  SettingDetailsModel(detailParameter: Detail.maxTemp, isOn: true),
                                  SettingDetailsModel(detailParameter: Detail.feelsLike, isOn: true),
                                  SettingDetailsModel(detailParameter: Detail.pressure, isOn: true)]

    // MARK: - GET parameters funcs
    func getValueHour() -> Hour {
        return valueHour
    }

    func getValueUnit() -> Unit {
        return valueUnit
    }

    func getValueDistance() -> Distance {
        return valueDistance
    }

    // MARK: - SET parameters funcs
    func setValueHour(newValue: Hour) {
        valueHour = newValue
    }

    func setValueUnit(newValue: Unit) {
        valueUnit = newValue
    }

    func setValueDistance(newValue: Distance) {
        valueDistance = newValue
    }

    // MARK: - GET details funcs
    func getSettingDetails() -> [SettingDetailsModel] {
        return settingDetails
    }

    // MARK: - SET details funcs
    func setSettingDetails(newSettingDetails: [SettingDetailsModel]) {
        settingDetails = newSettingDetails
    }
}
