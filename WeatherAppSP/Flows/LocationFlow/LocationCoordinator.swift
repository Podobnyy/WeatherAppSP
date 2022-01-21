import UIKit

final class LocationCoordinator: BaseCoordinator {

    // MARK: - Properties
    private let router: Router
    private let moduleFactory: LocationModuleFactory

    private var locationsViewController: LocationsViewController?

    var onLocationSelectedAction: (() -> Void)?

    // MARK: - Init
    init(router: Router, moduleFactory: LocationModuleFactory) {
        self.router = router
        self.moduleFactory = moduleFactory
    }

    override func start() {
        showLocationVC(animated: false)
    }

    // MARK: - Private funcs
    private func showLocationVC(animated: Bool) {
        guard let locationsViewController: LocationsViewController = moduleFactory.makeLocationVC() else { return }

        self.locationsViewController = locationsViewController

        locationsViewController.addLocation = { [weak self] in
            self?.showAddLocationVC()
        }

        locationsViewController.locationSelected = { [weak self] in
            self?.onLocationSelectedAction?()
        }

        router.push(locationsViewController, animated: animated)
    }

    private func showAddLocationVC() {
        guard let addLocationVC: AddLocationViewController = moduleFactory.makeAddLocationVC()  else { return }

        addLocationVC.delegate = locationsViewController
        let navigationController = UINavigationController(rootViewController: addLocationVC)
        router.present(navigationController, animated: true)
    }
}
