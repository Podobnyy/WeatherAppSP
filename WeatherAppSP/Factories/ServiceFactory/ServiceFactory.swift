protocol ServiceFactory {

    var networkManager: NetworkManager { get }

    var settingsManager: SettingsManager { get }
    var userSettings: UserSettings { get }
    var userDataManager: UserDataManager { get }
    var converterManager: СonverterManager { get }

    var imageWeather: ImageWeather { get }
    var weatherDateFormatter: WeatherDateFormatter { get }
    var labelFormatter: LabelFormatter { get }
}
