protocol CoordinatorFactory {

    func makeLocationCoordinator(router: Router) -> LocationCoordinator
    func makeWeatherCoordinator(router: Router, coordinatorFactory: CoordinatorFactory) -> WeatherCoordinator
    func makeSettingsCoordinator(router: Router) -> SettingsCoordinator
}
