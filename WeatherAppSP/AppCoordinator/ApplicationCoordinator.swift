final class ApplicationCoordinator: BaseCoordinator {

    private let router: Router
    private let userDataManager = UserDataManager.shared

    init(router: Router) {
        self.router = router
    }

    override func start() {
        runLocationsFlow()

        if userDataManager.getSelectedLocation() != nil {
            runWeatherFlow()
        }
    }

    private func runLocationsFlow() {
        let coordinator = LocationCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }

        coordinator.onLocationSelectedAction = { [weak self] in
            self?.runWeatherFlow()
        }

        addDependency(coordinator)
        coordinator.start()
    }

    private func runWeatherFlow() {
        let coordinator = WeatherCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
