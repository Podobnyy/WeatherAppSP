import UIKit

final class SettingsCoordinator: BaseCoordinator {

    // MARK: - Properties
    private let router: Router

    // MARK: - Init
    init(router: Router) {
        self.router = router
    }

    override func start() {
        showSettingsVC()
    }

    // MARK: - Private funcs
    private func showSettingsVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let settingsVC: SettingsViewController = storyboard.instantiateVC() else { return }

        settingsVC.selectSettings = { [weak self] in
            self?.showSettingsDetailsVC()
        }

        router.setRootModule(settingsVC)
    }

    private func showSettingsDetailsVC() {
        let storyboard = UIStoryboard.init(name: String(describing: SettingDetailsViewController.self), bundle: nil)
        guard let settingDetailViewController: SettingDetailsViewController = storyboard.instantiateVC() else { return }

        router.push(settingDetailViewController)
    }
}
