import UIKit

final class LocationCoordinator: BaseCoordinator {

    // MARK: - Properties
    private let router: Router
    var onLocationSelectedAction: (() -> Void)?

    // MARK: - Init
    init(router: Router) {
        self.router = router
    }

    override func start() {
        showLocationVC(animated: false)
    }

    // MARK: - Private funcs
    private func showLocationVC(animated: Bool) {
        let storyboard = UIStoryboard.init(name: String(describing: LocationsViewController.self), bundle: nil)
        guard let locationsViewController: LocationsViewController = storyboard.instantiateVC() else { return }

        locationsViewController.addLocation = { [weak self] in
            self?.showAddLocationVC()
        }

        locationsViewController.locationSelected = { [weak self] in
            self?.onLocationSelectedAction?()
        }

        router.push(locationsViewController, animated: animated)
    }

    private func showAddLocationVC() {
        let storyboard = UIStoryboard.init(name: String(describing: AddLocationViewController.self), bundle: nil)
        guard let addLocationVC: AddLocationViewController = storyboard.instantiateVC() else { return }

        let navigationController = UINavigationController(rootViewController: addLocationVC)
        router.present(navigationController, animated: true)
    }
}
