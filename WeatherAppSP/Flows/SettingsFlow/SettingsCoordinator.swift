import UIKit

final class SettingsCoordinator: BaseCoordinator {

    // MARK: - Properties
    private let router: Router
    private let moduleFactory: SettingsModuleFactory

    // MARK: - Init
    init(router: Router, moduleFactory: SettingsModuleFactory) {
        self.router = router
        self.moduleFactory = moduleFactory
    }

    override func start() {
        showSettingsVC()
    }

    // MARK: - Private funcs
    private func showSettingsVC() {
        guard let settingsVC: SettingsViewController = moduleFactory.makeSettingsVC() else { return }

        settingsVC.selectSettings = { [weak self] in
            self?.showSettingsDetailsVC()
        }

        router.setRootModule(settingsVC)
    }

    private func showSettingsDetailsVC() {
        guard let settingDetailVC: SettingDetailsViewController = moduleFactory.makeSettingDetailsVC() else { return }

        router.push(settingDetailVC)
    }
}
