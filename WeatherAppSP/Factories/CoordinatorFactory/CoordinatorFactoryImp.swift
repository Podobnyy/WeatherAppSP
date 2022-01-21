final class CoordinatorFactoryImp: CoordinatorFactory {

    func makeLocationCoordinator(router: Router, moduleFactory: ModuleFactoryImp) -> LocationCoordinator {
        return LocationCoordinator(router: router, moduleFactory: moduleFactory)
    }

    func makeWeatherCoordinator(router: Router,
                                moduleFactory: ModuleFactoryImp,
                                coordinatorFactory: CoordinatorFactory) -> WeatherCoordinator {

        return WeatherCoordinator(router: router,
                                  moduleFactory: moduleFactory,
                                  coordinatorFactory: coordinatorFactory)
    }

    func makeSettingsCoordinator(router: Router, moduleFactory: ModuleFactoryImp) -> SettingsCoordinator {
        return SettingsCoordinator(router: router, moduleFactory: moduleFactory)
    }
}
