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

final class SettingsManager: NSObject, NSCoding {

    static let shared = SettingsManager()

    private override init() {}

    private let converterManager = СonverterManager.shared

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
        coder.encode(valueHour.rawValue, forKey: SettingsKey.valueHour.rawValue)
        coder.encode(valueUnit.rawValue, forKey: SettingsKey.valueUnit.rawValue)
        coder.encode(valueDistance.rawValue, forKey: SettingsKey.valueDistance.rawValue)
    }

    required init?(coder: NSCoder) {
        valueHour = Hour(rawValue: (coder.decodeObject(forKey: SettingsKey.valueHour.rawValue)
                                    as? String ?? "")) ?? .twentyFour
        valueUnit = Unit(rawValue: (coder.decodeObject(forKey: SettingsKey.valueUnit.rawValue)
                                    as? String ?? "")) ?? .celsius
        valueDistance = Distance(rawValue: (coder.decodeObject(forKey: SettingsKey.valueDistance.rawValue)
                                            as? String ?? "")) ?? .kilometre
    }

    // MARK: - func for Converter Hour/Unit/Distance
    func getHourSelectedFormat(hourTwentyFour: String) -> String {
        switch getValueHour() {
        case .twelve: return String(converterManager.getTwelveHourFromTwentyFourHour(Int(hourTwentyFour) ?? 0))
        case .twentyFour:
            return hourTwentyFour
        }
    }

    func getHourWithMinutesSelectedFormat(hourTwentyFour: String) -> String {
        switch getValueHour() {
        case .twelve: return converterManager.getTwelveHourFromTwentyFourHourWithMinutes(hourTwentyFour)
        case .twentyFour: return hourTwentyFour
        }
    }

    func getUnitSelectedFormat(celsius: Double) -> String {
        switch getValueUnit() {
        case .celsius: return "\(Int(round(celsius)))°C"
        case .fahrenheit: return "\(Int(round(converterManager.getFahrenheitFromСelsius(celsius))))°F"
        }
    }

    func getDistanceSelectedFormat(metre: Double) -> String {
        switch getValueDistance() {
        case .kilometre: return "\(Int(round(metre)))m/s"
        case .mile: return "\(Int(round(converterManager.getFootSecondFromMetreSecond(metre))))ft/s"
        }
    }

    // MARK: - GET funcs
    func getValueHour() -> Hour {
        return userDefaults.getValueHour() ?? valueHour
    }

    func getValueUnit() -> Unit {
        return userDefaults.getValueUnit() ?? valueUnit
    }

    func getValueDistance() -> Distance {
        return userDefaults.getValueDistance() ?? valueDistance
    }

    func getSettingDetails() -> [SettingDetailsModel] {
        return userDefaults.getSettingDetails() ?? settingDetails
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
