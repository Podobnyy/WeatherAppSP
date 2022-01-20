final class ServiceFactoryImp: ServiceFactory {

    lazy var networkManager = NetworkManager()

    lazy var settingsManager = SettingsManager()
    lazy var userSettings = UserSettings()
    lazy var userDataManager = UserDataManager()
    lazy var converterManager = СonverterManager()

    lazy var imageWeather = ImageWeather()
    lazy var weatherDateFormatter = WeatherDateFormatter()
    lazy var labelFormatter = LabelFormatter()
}
