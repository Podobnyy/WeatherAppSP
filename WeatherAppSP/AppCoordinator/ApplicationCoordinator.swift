final class ApplicationCoordinator: BaseCoordinator {

    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    private let userDataManager = UserDataManager.shared

    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        runLocationsFlow()

        if userDataManager.getSelectedLocation() != nil {
            runWeatherFlow()
        }
    }

    private func runLocationsFlow() {
//        let coordinator = LocationCoordinator(router: router)
        // TODO: delete UP
//      coordinatorFactory.makeLocationCoordinator
        let coordinator = coordinatorFactory.makeLocationCoordinator(router: router)

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
//        let coordinator = WeatherCoordinator(router: router)
        // TODO: delete UP
//        coordinatorFactory.makeWeatherCoordinator
        let coordinator = coordinatorFactory.makeWeatherCoordinator(router: router,
                                                                    coordinatorFactory: coordinatorFactory)

        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
