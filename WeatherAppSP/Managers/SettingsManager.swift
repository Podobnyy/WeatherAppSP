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

class SettingsManager: NSObject, NSCoding {

    static let shared = SettingsManager()

    private override init() {}

    private var valueHour = Hour.twentyFour
    private var valueUnit = Unit.celsius
    private var valueDistance = Distance.kilometre

    private var settingDetails = [SettingDetailsModel(detailParameter: Detail.humidity, isOn: true),
                                  SettingDetailsModel(detailParameter: Detail.windSpeed, isOn: true),
                                  SettingDetailsModel(detailParameter: Detail.minTemp, isOn: true),
                                  SettingDetailsModel(detailParameter: Detail.maxTemp, isOn: true),
                                  SettingDetailsModel(detailParameter: Detail.feelsLike, isOn: true),
                                  SettingDetailsModel(detailParameter: Detail.pressure, isOn: true)]

    private let userDefaults = UserSettings.shared

    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(valueHour.rawValue, forKey: "valueHour")
        coder.encode(valueUnit.rawValue, forKey: "valueUnit")
        coder.encode(valueDistance.rawValue, forKey: "valueDistance")
    }

    required init?(coder: NSCoder) {
        valueHour = Hour(rawValue: (coder.decodeObject(forKey: "valueHour") as? String ?? "")) ?? Hour.twentyFour
        valueUnit = Unit(rawValue: (coder.decodeObject(forKey: "valueUnit") as? String ?? "")) ?? Unit.celsius
        valueDistance = Distance(rawValue: (coder.decodeObject(forKey: "valueDistance")
                                            as? String ?? "")) ?? Distance.kilometre
    }

    // MARK: - GET funcs
    func getValueHour() -> Hour {
        if let value: Hour = userDefaults.getValueHour() {
            return value
        } else {
            return valueHour
        }
    }

    func getValueUnit() -> Unit {
        if let value: Unit = userDefaults.getValueUnit() {
            return value
        } else {
            return valueUnit
        }
    }

    func getValueDistance() -> Distance {
        if let value: Distance = userDefaults.getValueDistance() {
            return value
        } else {
            return valueDistance
        }
    }

    func getSettingDetails() -> [SettingDetailsModel] {
        if let details: [SettingDetailsModel] = userDefaults.getSettingDetails() {
            return details
        } else {
            return settingDetails
        }
    }

    // MARK: - SET funcs
    func setValueHour(newValue: Hour) {
        valueHour = newValue
        userDefaults.saveValueHour(newValue: newValue)
    }

    func setValueUnit(newValue: Unit) {
        valueUnit = newValue
        userDefaults.saveValueUnit(newValue: newValue)
    }

    func setValueDistance(newValue: Distance) {
        valueDistance = newValue
        userDefaults.saveValueDistance(newValue: newValue)
    }

    func setSettingDetails(newSettingDetails: [SettingDetailsModel]) {
        settingDetails = newSettingDetails
        userDefaults.saveSettingDetails(newSettingDetails: newSettingDetails)
    }
}
