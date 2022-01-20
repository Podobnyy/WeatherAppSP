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
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let settingsVC: SettingsViewController = storyboard.instantiateVC() else { return }
        // TODO: delete UP
//        ModuleFactoryImp.makeSettingsVC()
        guard let settingsVC: SettingsViewController = moduleFactory.makeSettingsVC() else { return }

        settingsVC.selectSettings = { [weak self] in
            self?.showSettingsDetailsVC()
        }

        router.setRootModule(settingsVC)
    }

    private func showSettingsDetailsVC() {
//        let storyboard = UIStoryboard.init(name: String(describing: SettingDetailsViewController.self), bundle: nil)
//        guard let settingDetailViewController: SettingDetailsViewController = storyboard.instantiateVC() else { return }
        // TODO: delete UP
//        ModuleFactoryImp.makeSettingDetailsVC()
        guard let settingDetailViewController: SettingDetailsViewController =
                moduleFactory.makeSettingDetailsVC() else { return }

        router.push(settingDetailViewController)
    }
}
