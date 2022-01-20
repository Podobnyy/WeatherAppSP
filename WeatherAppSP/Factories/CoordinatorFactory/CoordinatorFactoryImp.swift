final class CoordinatorFactoryImp: CoordinatorFactory {

    func makeLocationCoordinator(router: Router) -> LocationCoordinator {
        return LocationCoordinator(router: router, moduleFactory: ModuleFactoryImp())
    }

    func makeWeatherCoordinator(router: Router, coordinatorFactory: CoordinatorFactory) -> WeatherCoordinator {
        return WeatherCoordinator(router: router,
                                  moduleFactory: ModuleFactoryImp(),
                                  coordinatorFactory: coordinatorFactory)
    }

    func makeSettingsCoordinator(router: Router) -> SettingsCoordinator {
        return SettingsCoordinator(router: router, moduleFactory: ModuleFactoryImp())
    }
}
