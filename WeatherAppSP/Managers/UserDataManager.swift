import Foundation

enum DataKey: String {
    case forecastDays
    case listOfLocations
}

final class UserDataManager {

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

    func getListOfLocationsFromUserDefaults() -> [LocationModel]? {
        guard let savedData = defaults.object(forKey: DataKey.listOfLocations.rawValue) as? Data, let decodedModel =
                try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [LocationModel] else {
                    return nil }
        return decodedModel
    }

    // MARK: - Save in UserDefaults
    func saveForecastDaysInUserDefaults(forecastDays: [ForecastDayModel]) {
        guard let savedData = try? NSKeyedArchiver.archivedData(withRootObject: forecastDays,
                                                                requiringSecureCoding: false) else { return }
        defaults.set(savedData, forKey: DataKey.forecastDays.rawValue)
    }

    func setListOfLocationsInUserDefaults(listOfLocations: [LocationModel]) {
        guard let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfLocations,
                                                                requiringSecureCoding: false) else { return }
        defaults.set(savedData, forKey: DataKey.listOfLocations.rawValue)
    }
}
