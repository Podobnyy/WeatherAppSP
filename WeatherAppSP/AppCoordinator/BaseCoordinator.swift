protocol Coordinator: AnyObject {
    func start()
}

class BaseCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    var finishFlow: (() -> Void)?

    func start() { }

    func addDependency(_ coordinator: Coordinator) {
        // add only unique object
        for element in childCoordinators where element === coordinator { return }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
