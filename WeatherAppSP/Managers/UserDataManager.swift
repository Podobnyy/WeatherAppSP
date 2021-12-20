//
//  UserDataManager.swift
//  WeatherAppSP
//
//  Created by Сергей Александрович on 20.12.2021.
//

import Foundation

enum DataKey: String {
    case forecastDays
}

class UserDataManager {

    static let shared = UserDataManager()

    private init() {}

    private let defaults = UserDefaults.standard

    // MARK: - Read from UserDefaults
    func getForecastDaysFromUserDefaults() -> [ForecastDayModel]? {
        guard let savedData = defaults.object(forKey: DataKey.forecastDays.rawValue) as? Data, let decodedModel =
                try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [ForecastDayModel] else {
                    return nil }
        return decodedModel
    }

    // MARK: - Save in UserDefaults
    func saveForecastDaysInUserDefaults(forecastDays: [ForecastDayModel]) {
        guard let savedData = try? NSKeyedArchiver.archivedData(withRootObject: forecastDays,
                                                                requiringSecureCoding: false)  else { return }
        defaults.set(savedData, forKey: DataKey.forecastDays.rawValue)
    }
}
