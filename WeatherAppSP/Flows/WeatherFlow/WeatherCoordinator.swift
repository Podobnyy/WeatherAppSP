import UIKit

final class WeatherCoordinator: BaseCoordinator {

    // MARK: - Properties
    private let router: Router

    private let settingsNavigationController = UINavigationController()

    private var weatherViewController = WeatherViewController()
    private var tabBarController = TabBarController()

    // MARK: - Init
    init(router: Router) {
        self.router = router
    }

    override func start() {
        setupTabBarController()
        showTabBarController()
    }

    // MARK: - Private funcs
    private func setupTabBarController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let weatherViewController: WeatherViewController = storyboard.instantiateVC(),
              let forecastViewController: ForecastViewController = storyboard.instantiateVC() else { return }

        self.weatherViewController = weatherViewController

        guard let tabBarController: TabBarController = storyboard.instantiateVC() else { return }

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
        let coordinator = SettingsCoordinator(router: settingsRouter)
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
