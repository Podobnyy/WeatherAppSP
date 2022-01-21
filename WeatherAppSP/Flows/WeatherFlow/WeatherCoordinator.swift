import UIKit

final class WeatherCoordinator: BaseCoordinator {

    // MARK: - Properties
    private let router: Router
    private let moduleFactory: ModuleFactoryImp
    private let coordinatorFactory: CoordinatorFactory

    private let settingsNavigationController = UINavigationController()

    private var weatherViewController = WeatherViewController()
    private var tabBarController = TabBarController()

    // MARK: - Init
    init(router: Router,
         moduleFactory: ModuleFactoryImp,
         coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        setupTabBarController()
        showTabBarController()
    }

    // MARK: - Private funcs
    private func setupTabBarController() {
        guard let weatherViewController: WeatherViewController = moduleFactory.makeWeatherVC(),
              let forecastViewController: ForecastViewController = moduleFactory.makeForecastVC() else { return }

        self.weatherViewController = weatherViewController

        guard let tabBarController = moduleFactory.makeTabBarController() else { return }

        tabBarController.titleItems = [TabBarTitle.weather, TabBarTitle.forecastDays, TabBarTitle.settings]
        tabBarController.viewControllers = [weatherViewController, forecastViewController, settingsNavigationController]
        self.tabBarController = tabBarController
    }

    // MARK: - Show and Run funcs
    private func showTabBarController() {
        weatherViewController.onSelectLocationAction = { [weak self] in
            self?.router.popModule()
            self?.finishFlow?()
        }

        tabBarController.onSelectSettingsAction = { [weak self] in
            self?.runSettingsFlow()
        }

        router.push(tabBarController)
    }

    private func runSettingsFlow() {
        let settingsRouter = RouterImp(rootController: settingsNavigationController)
        let coordinator = coordinatorFactory.makeSettingsCoordinator(router: settingsRouter,
                                                                     moduleFactory: moduleFactory)

        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }

        tabBarController.onSettingsSelectedAction = {
            coordinator.finishFlow?()
        }

        addDependency(coordinator)
        coordinator.start()
    }
}
