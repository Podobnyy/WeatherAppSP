final class ApplicationCoordinator: BaseCoordinator {

    private let applicationFactory: ApplicationFactoryImp
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory

    private let userDataManager: UserDataManager

    init(applicationFactory: ApplicationFactoryImp, router: Router) {
        self.applicationFactory = applicationFactory
        self.router = router

        coordinatorFactory = applicationFactory.getCoordinatorFactory()
        userDataManager = applicationFactory.getModuleFactory().serviceFactory.userDataManager
    }

    override func start() {
        runLocationsFlow()

        if userDataManager.getSelectedLocation() != nil {
            runWeatherFlow()
        }
    }

    private func runLocationsFlow() {
        let coordinator = coordinatorFactory.makeLocationCoordinator(
            router: router,
            moduleFactory: applicationFactory.getModuleFactory()
        )

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
        let coordinator = coordinatorFactory.makeWeatherCoordinator(
            router: router,
            moduleFactory: applicationFactory.getModuleFactory(),
            coordinatorFactory: coordinatorFactory
        )

        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
