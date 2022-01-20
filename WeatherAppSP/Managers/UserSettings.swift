//
//  UserSettings.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 15.12.2021.
//

import Foundation

enum SettingsKey: String {
    case valueHour
    case valueUnit
    case valueDistance
    case settingDetails
}

final class UserSettings {

    private let defaults = UserDefaults.standard

    init() {}
    
    // MARK: - Read from UserDefaults
    func getValueHour() -> Hour? {
        guard let savedData = defaults.object(forKey: SettingsKey.valueHour.rawValue) as? Data, let decodedModel =
                try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? Hour.RawValue else { return nil }
        return Hour.init(rawValue: decodedModel)
    }

    func getValueUnit() -> Unit? {
        guard let savedData = defaults.object(forKey: SettingsKey.valueUnit.rawValue) as? Data, let decodedModel =
                try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? Unit.RawValue else { return nil }
        return Unit.init(rawValue: decodedModel)
    }

    func getValueDistance() -> Distance? {
        guard let savedData = defaults.object(forKey: SettingsKey.valueDistance.rawValue) as? Data, let decodedModel =
                try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? Distance.RawValue else {
                    return nil }
        return Distance.init(rawValue: decodedModel)
    }

    func getSettingDetails() -> [SettingDetailsModel]? {
        guard let savedData = defaults.object(forKey: SettingsKey.settingDetails.rawValue) as? Data, let decodedModel =
                try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [SettingDetailsModel] else {
                    return nil }
        return decodedModel
    }

    // MARK: - Save in UserDefaults
    func saveValueHour(newValue: Hour) {
        save(newValue: newValue.rawValue, key: SettingsKey.valueHour.rawValue)
    }

    func saveValueUnit(newValue: Unit) {
        save(newValue: newValue.rawValue, key: SettingsKey.valueUnit.rawValue)
    }

    func saveValueDistance(newValue: Distance) {
        save(newValue: newValue.rawValue, key: SettingsKey.valueDistance.rawValue)
    }

    private func save(newValue: String, key: String) {
        guard let savedData = try? NSKeyedArchiver.archivedData(withRootObject: newValue,
                                                                requiringSecureCoding: false) else { return }
        defaults.set(savedData, forKey: key)
    }

    func saveSettingDetails(newSettingDetails: [SettingDetailsModel]) {
        guard let savedData = try? NSKeyedArchiver.archivedData(withRootObject: newSettingDetails,
                                                                requiringSecureCoding: false)  else { return }
        defaults.set(savedData, forKey: SettingsKey.settingDetails.rawValue)
    }
}
