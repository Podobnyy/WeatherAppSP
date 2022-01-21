protocol CoordinatorFactory {

    func makeLocationCoordinator(router: Router, moduleFactory: ModuleFactoryImp) -> LocationCoordinator
    func makeWeatherCoordinator(router: Router,
                                moduleFactory: ModuleFactoryImp,
                                coordinatorFactory: CoordinatorFactory) -> WeatherCoordinator
    func makeSettingsCoordinator(router: Router, moduleFactory: ModuleFactoryImp) -> SettingsCoordinator
}
