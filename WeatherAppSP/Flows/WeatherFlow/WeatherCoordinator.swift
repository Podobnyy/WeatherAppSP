import UIKit

final class WeatherCoordinator: BaseCoordinator {

    // MARK: - Properties
    private let router: Router

    private let settingsNavigationController = UINavigationController()
    private let settingsRouter: Router

    private var tabBarController = TabBarController()
    private let userDataManager = UserDataManager.shared

    // MARK: - Init
    init(router: Router) {
        self.router = router
        settingsRouter = RouterImp(rootController: settingsNavigationController)
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

        guard let tabBarController: TabBarController = storyboard.instantiateVC() else { return }

        tabBarController.viewControllers = [weatherViewController, forecastViewController, settingsNavigationController]
        self.tabBarController = tabBarController
    }

    private func showTabBarController() {
        tabBarController.selectLocation = { [weak self] in
            self?.router.popModule()
            self?.finishFlow?()
        }

        tabBarController.selectSettings = { [weak self] in
            self?.runSettingsFlow()
        }

        router.push(tabBarController)
    }

    private func runSettingsFlow() {
        let coordinator = SettingsCoordinator(router: settingsRouter)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }

        tabBarController.settingsSelected = {
            coordinator.finishFlow?()
        }

        addDependency(coordinator)
        coordinator.start()
    }
}
