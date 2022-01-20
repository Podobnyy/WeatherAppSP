protocol WeatherModuleFactory {

    func makeWeatherVC() -> WeatherViewController?
    func makeForecastVC() -> ForecastViewController?
    func makeTabBarController() -> TabBarController?
}
