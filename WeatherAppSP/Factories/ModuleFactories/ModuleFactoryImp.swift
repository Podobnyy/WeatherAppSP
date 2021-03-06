import UIKit

final class ModuleFactoryImp {

    var serviceFactory = ServiceFactoryImp()
}

extension ModuleFactoryImp: LocationModuleFactory {

    func makeLocationVC() -> LocationsViewController? {
        let storyboard = UIStoryboard.init(name: String(describing: LocationsViewController.self), bundle: nil)
        guard let locationsVC: LocationsViewController = storyboard.instantiateVC() else { return nil}

        locationsVC.networkManager = serviceFactory.networkManager
        locationsVC.settingsManager = serviceFactory.settingsManager
        locationsVC.userDataManager = serviceFactory.userDataManager
        return locationsVC
    }

    func makeAddLocationVC() -> AddLocationViewController? {
        let storyboard = UIStoryboard.init(name: String(describing: AddLocationViewController.self), bundle: nil)
        guard let addLocationVC: AddLocationViewController = storyboard.instantiateVC() else { return nil }

        return addLocationVC
    }
}

extension ModuleFactoryImp: WeatherModuleFactory {

    func makeWeatherVC() -> WeatherViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let weatherVC: WeatherViewController = storyboard.instantiateVC() else { return nil }

        weatherVC.networkManager = serviceFactory.networkManager
        weatherVC.settingsManager = serviceFactory.settingsManager
        weatherVC.userDataManager = serviceFactory.userDataManager
        weatherVC.imageWeather = serviceFactory.imageWeather
        weatherVC.weatherDateFormatter = serviceFactory.weatherDateFormatter
        weatherVC.labelFormatter = serviceFactory.labelFormatter
        return weatherVC
    }

    func makeForecastVC() -> ForecastViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let forecastVC: ForecastViewController = storyboard.instantiateVC() else { return nil }

        forecastVC.settingsManager = serviceFactory.settingsManager
        forecastVC.userDataManager = serviceFactory.userDataManager
        forecastVC.imageWeather = serviceFactory.imageWeather
        return forecastVC
    }

    func makeTabBarController() -> TabBarController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarController: TabBarController = storyboard.instantiateVC() else { return nil }

        return tabBarController
    }
}

extension ModuleFactoryImp: SettingsModuleFactory {

    func makeSettingsVC() -> SettingsViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let settingsVC: SettingsViewController = storyboard.instantiateVC() else { return nil}

        settingsVC.settingsManager = serviceFactory.settingsManager
        settingsVC.labelFormatter = serviceFactory.labelFormatter
        return settingsVC
    }

    func makeSettingDetailsVC() -> SettingDetailsViewController? {
        let storyboard = UIStoryboard.init(name: String(describing: SettingDetailsViewController.self), bundle: nil)
        guard let settingDetailVC: SettingDetailsViewController = storyboard.instantiateVC() else { return nil }

        settingDetailVC.settingsManager = serviceFactory.settingsManager
        return settingDetailVC
    }
}
